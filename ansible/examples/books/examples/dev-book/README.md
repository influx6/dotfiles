# Ansible::PriveBackend
This project provides ansible setup scripts which can be used to provision a
VM or host system ready for development. The help you go halfway to reduce setup time,
allowing you to concentrate more on setting up eclipse and associated artifacts.

## Setup
You must first install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html), which
be installed either through it's PPA or through [Python Pip](https://pypi.org/project/pip/) as below:

```bash
sudo apt install -y python-pip

pip install ansible
```

## Need To Know

Executing the ansible script requires using inventories that point ansible to target servers, vms or hosts, these 
are in [inventories](./inventories). Before using the [VM Inventory](./inventories/vm.yaml), ensure to update the IPs
appropriately for the target hosts you wish to use, more so, these hosts should have your ssh pub key within their
[authorized_keys](https://www.ssh.com/ssh/authorized_keys/) as we will be using ssh keys instead as they are more secure.
  
  
## Verification
If you wish to verify ansible is working properly, just run the hello playbook:

```bash
make hello
```

This will run a simple hello playbook on your system (aka localhost).

## Local setup
To set up your local system instead of a vm, simply run the following in the root directory:

Elevate your user to be able to use `sudo` without password:

```bash
sudo su $USER
```

- Run below command to set up your system in readiness for the [SlyAWS](https://github.com/JSchillinger/SlyAWS) project:

```bash
make sly inventory=inventory/localhost.yaml user=darkvoid
```

- Run below command to set up your system in readiness for the [PriveMicro](https://github.com/JSchillinger/PriveMicro) project:

```bash
make micro inventory=inventory/localhost.yaml user=darkvoid
```

Set the `user` argument to the username for your account on your system

You will see a directory called `ThingsYouNeed` in the user's home directory which contains different files you will need
during setup (e.g like `eclipse.ini` file to use for eclipse)


## VMs
We will be using [Multipass](https://multipass.run/) to setup VMs for use in development, as it makes it 
really easy to lunch them quickly. You can set up both multipass and the 3 VMs using these commands:

First, elevate your user to be able to use `sudo` without password:

```bash
sudo su $USER
```

Then run below to setup 3 vms (1 master, 2 slaves):

```bash
make vm inventory=inventory/localhost.yaml user=$USER
```

Once successfully done, we can see all vms launched with:

```bash
multipass ls
```

Which should show a response following below format (your IP details will be different)

```bash
Name                    State             IPv4             Image
master                  Running           10.235.108.229   Ubuntu 18.04 LTS
slave1                  Running           10.235.108.91    Ubuntu 18.04 LTS
slave2                  Running           10.235.108.92    Ubuntu 18.04 LTS
```

More so, ansible would have generated a new inventory file called `multipass_vm_inventory.yaml`
which you can use to supply to ansible for setting these VMs up.

Before, setting them up, you must first ssh into each host and copy your ssh public key from the host into each 
vms [authorized_keys file](https://www.ssh.com/ssh/authorized_keys/) in `~/.ssh/authorized_keys`, which would 
allow you to both ssh into them without a password and allow ansible connect into them for execution.

You can use multipass to ssh into the master (and slaves) like so:

```bash
multipass shell master
```

Which then allows you to add the needed ssh keys as needed.

*Hint: To add your keys into the host, just copy contents in your ssh key pub file (e.g `~/.ssh/id_rsa.pub`) into the `authorized_keys` on a new line.*

Once the keys have being copied properly, then you can execute either the SlyAWS or PriveMicro 
ansible playbooks to set up all the VMs appropriately, like below:

- Run below command to set up your system in readiness for the [SlyAWS](https://github.com/JSchillinger/SlyAWS) project:

```bash
make sly inventory=./multipass_vm_inventory.yaml user=ubuntu
```

- Run below command to set up your system in readiness for the [PriveMicro](https://github.com/JSchillinger/PriveMicro) project:

```bash
make micro inventory=./multipass_vm_inventory.yaml user=ubuntu
```

Once done your vms should have all necessary software packages installed and ready for your use.

*You will see a directory called `ThingsYouNeed` in the user's home directory which contains different files you will need*

With this done, move on to [Setting up Eclipse](https://sites.google.com/privetechnologies.com/tech/tech/devops/virtualization/setup-of-developer-box?pli=1&authuser=1#h.p_6hQiR-j74Wy-)
and [Configuring Eclipse](https://sites.google.com/a/wismore.com/privemanagers-developer-wiki/development/build-environment/eclipse).


## Others
The other playbooks exists within the repository for specific needs which does not apply to all, 
feel free to use if desired:

#### Doom Emacs

For those who like to use emacs, attached is a playbook to set up [Doom Emacs](https://github.com/hlissner/doom-emacs)

```bash
make custom user=darkvoid inventory=./inventories/localhost.yaml play=./doom_emacs.yaml
```

*Feel free to change the `inventory` to one for vms if you so wish.*

#### Local Kubernetes cluster with Microk8s

If you prefer using kubernetes locally for development as well, you have use below playbook 
setup [Microk8s](https://microk8s.io/) with the master and slave vms for local development.

You are required to first setup these 3 vms described in the [VMs](#vms) section.

Then install kubectl into your localhost:

```bash
make custom user=darkvoid inventory=./inventories/localhost.yaml play=./kubectl.yaml
```

After which we setup K8S with [Microk8s](https://microk8s.io/) using:

```bash
make k8s user=ubuntu inventory=./multipass_vm_inventory.yaml
```

Once done, the necessary `kubeconfig` needed to interact with the cluster
will be in `./artifacts/master/kubeconfig` directory, which should be copied to `$HOME/.kube/config`.

With that, you are ready to interact with your cluster
