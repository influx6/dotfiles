16 Dec 2022 - [@chuxel](https://github.com/chuxel)

When creating a development container, you have a variety of different ways to customize your environment like [“Features”](https://containers.dev/features) or [lifecycle scripts](https://containers.dev/implementors/json_reference/#lifecycle-scripts). However, if you are familiar with containers, you may want to use a [Dockerfile](https://containers.dev/guide/dockerfile#dockerfile) or [Docker Compose / Compose](https://containers.dev/guide/dockerfile#docker-compose) to customize your environment. This article will walk through how to use these formats with the Dev Container spec.

## [Using a Dockerfile](https://containers.dev/guide/dockerfile#dockerfile)

To keep things simple, many [Dev Container Templates](https://containers.dev/templates) use container image references.

```
<span>{</span><span>
    </span><span>"image"</span><span>:</span><span> </span><span>"mcr.microsoft.com/devcontainers/base:ubuntu"</span><span>
</span><span>}</span><span>
</span>
```

However, [Dockerfiles](https://docs.docker.com/engine/reference/builder/) are a great way to extend images, add additional native OS packages, or make minor edits to the OS image. You can reuse any Dockerfile, but let’s walk through how to create one from scratch.

First, add a file named `Dockerfile` next to your `devcontainer.json`. For example:

```
<span>FROM</span><span> mcr.microsoft.com/devcontainers/base:ubuntu</span>
<span># Install the xz-utils package</span>
<span>RUN </span>apt-get update <span>&amp;&amp;</span> apt-get <span>install</span> <span>-y</span> xz-utils
```

Next, remove the `image` property from `devcontainer.json` (if it exists) and add the `build` and `dockerfile` properties instead:

```
<span>{</span><span>
    </span><span>"build"</span><span>:</span><span> </span><span>{</span><span>
        </span><span>//</span><span> </span><span>Path</span><span> </span><span>is</span><span> </span><span>relative</span><span> </span><span>to</span><span> </span><span>the</span><span> </span><span>devcontainer.json</span><span> </span><span>file.</span><span>
        </span><span>"dockerfile"</span><span>:</span><span> </span><span>"Dockerfile"</span><span>
    </span><span>}</span><span>
</span><span>}</span><span>
</span>
```

That’s it! When you start up your Dev Container, the Dockerfile will be automatically built with no additional work. See [Dockerfile scenario reference](https://containers.dev/implementors/json_reference/#image-specific) for more information on other related devcontainer.json properties.

### [Iterating on an image that includes Dev Container metadata](https://containers.dev/guide/dockerfile#dockerfile-image-iteration)

Better yet, you can can use a Dockerfile as a part of authoring an image you can share with others. You can even **add Dev Container settings and metadata right into the image itself**. This avoids having to duplicate config and settings in multiple devcontainer.json files and keeps them in sync with your images!

See the guide on **[pre-building](https://containers.dev/guide/prebuild)** to learn more!

## [Using Docker Compose](https://containers.dev/guide/dockerfile#docker-compose)

[Docker Compose](https://docs.docker.com/compose/) is a great way to define a multi-container development environment. Rather than adding things like databases or redis to your Dockerfile, you can reference existing images for these services and focus your Dev Container’s content on tools and utilities you need for development.

### [Using an image with Docker Compose](https://containers.dev/guide/dockerfile#docker-compose-image)

As mentioned in the Dockerfile section, to keep things simple, many [Dev Container Templates](https://containers.dev/templates) use container image references.

```
<span>{</span><span>
    </span><span>"image"</span><span>:</span><span> </span><span>"mcr.microsoft.com/devcontainers/base:ubuntu"</span><span>
</span><span>}</span><span>
</span>
```

Let’s create a `docker-compose.yml` file next to your `devcontainer.json` that references the same image and includes a PostgreSQL database:

```
<span>version</span><span>:</span> <span>'</span><span>3.8'</span>
<span>services</span><span>:</span>
  <span>devcontainer</span><span>:</span>
    <span>image</span><span>:</span> <span>mcr.microsoft.com/devcontainers/base:ubuntu</span>
    <span>volumes</span><span>:</span>
      <span>-</span> <span>../..:/workspaces:cached</span>
    <span>network_mode</span><span>:</span> <span>service:db</span>
    <span>command</span><span>:</span> <span>sleep infinity</span>

  <span>db</span><span>:</span>
    <span>image</span><span>:</span> <span>postgres:latest</span>
    <span>restart</span><span>:</span> <span>unless-stopped</span>
    <span>volumes</span><span>:</span>
      <span>-</span> <span>postgres-data:/var/lib/postgresql/data</span>
    <span>environment</span><span>:</span>
      <span>POSTGRES_PASSWORD</span><span>:</span> <span>postgres</span>
      <span>POSTGRES_USER</span><span>:</span> <span>postgres</span>
      <span>POSTGRES_DB</span><span>:</span> <span>postgres</span>

<span>volumes</span><span>:</span>
  <span>postgres-data</span><span>:</span>
```

In this example:

-   `../..:/workspaces:cached` mounts the workspace folder from the local source tree into the Dev Container.
-   `network_mode: service:db` puts the Dev Container on the same network as the database, so that it can access it on `localhost`.
-   The `db` section uses the [Postgres](https://hub.docker.com/_/postgres) image with a few settings.

Next, let’s configure devcontainer.json to use it.

```
<span>{</span><span>
    </span><span>"dockerComposeFile"</span><span>:</span><span> </span><span>"docker-compose.yml"</span><span>,</span><span>
    </span><span>"service"</span><span>:</span><span> </span><span>"devcontainer"</span><span>,</span><span>
    </span><span>"workspaceFolder"</span><span>:</span><span> </span><span>"/workspaces/${localWorkspaceFolderBasename}"</span><span>
</span><span>}</span><span>
</span>
```

In this example:

-   `service` indicates which service in the `docker-compose.yml` file is the Dev Container.
-   `dockerComposeFile` indicates where to find the `docker-compose.yml` file.
-   `workspaceFolder` indicates where to mount the workspace folder. This corresponds to a sub-folder under the mount point from `../..:/workspaces:cached` in the `docker-compose.yml` file.

That’s it!

### [Using a Dockerfile with Docker Compose](https://containers.dev/guide/dockerfile#docker-compose-dockerfile)

You can also combine these scenarios and use Dockerfile with Docker Compose. This time we’ll update `docker-compose.yml` to reference the Dockerfile by replacing `image` with a similar `build` section:

```
<span>version</span><span>:</span> <span>'</span><span>3.8'</span>
<span>services</span><span>:</span>
  <span>devcontainer</span><span>:</span>
    <span>build</span><span>:</span> 
      <span>context</span><span>:</span> <span>.</span>
      <span>dockerfile</span><span>:</span> <span>Dockerfile</span>
    <span>volumes</span><span>:</span>
      <span>-</span> <span>../..:/workspaces:cached</span>      
    <span>network_mode</span><span>:</span> <span>service:db</span>
    <span>command</span><span>:</span> <span>sleep infinity</span>

  <span>db</span><span>:</span>
    <span>image</span><span>:</span> <span>postgres:latest</span>
    <span>restart</span><span>:</span> <span>unless-stopped</span>
    <span>volumes</span><span>:</span>
      <span>-</span> <span>postgres-data:/var/lib/postgresql/data</span>
    <span>environment</span><span>:</span>
      <span>POSTGRES_PASSWORD</span><span>:</span> <span>postgres</span>
      <span>POSTGRES_USER</span><span>:</span> <span>postgres</span>
      <span>POSTGRES_DB</span><span>:</span> <span>postgres</span>

<span>volumes</span><span>:</span>
  <span>postgres-data</span><span>:</span>
```

Finally, as in the Dockerfile example, you can use this same setup to create a Dev Container image that you can share with others. You can also add Dev Container settings and metadata right into the image itself.

See the guide on **[pre-building](https://containers.dev/guide/prebuild)** to learn more!