ARG VARIANT=1-bullseye
FROM mcr.microsoft.com/devcontainers/rust:${VARIANT}

ARG USERNAME=ewestudio
ARG USER_UID=1001
ARG USER_GID=${USER_UID}

ARG GIT_EMAIL
ARG GIT_USER_NAME

ENV TERM=xterm-256color

COPY .vscode/git.alias /home/${USERNAME}/.git.alias
COPY .vscode/.gitconfig /home/${USERNAME}/.gitconfig

RUN	echo 'source $HOME/.git.alias' >> /home/${USERNAME}/.bashrc \
    && echo ${USER_GID} \
    && echo ${USER_UID} \
    && groupadd --gid ${USER_GID} ${USERNAME} || true \
    && useradd --uid ${USER_UID} --gid ${USER_GID} --shell /bin/bash ${USERNAME} \
    && mkdir -p /home/${USERNAME}/.config \
    && mkdir -p /home/${USERNAME}/.git \
    && apt-get update \
    && apt-get install -y sudo \
    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME} \
    && chown -R ${USER_UID}:${USER_GID} /home/${USERNAME} \
    && touch /home/${USERNAME}/.bashrc \
    && touch /home/${USERNAME}/.gitconfig \
    && git config --global user.email "${GIT_EMAIL}"  \
    && git config --global user.name "${GIT_USER_NAME}"  \
    && git clone https://github.com/pyenv/pyenv.git /home/${USERNAME}/.pyenv \
    && echo 'export PYENV_ROOT="$HOME/.pyenv"' >> /home/${USERNAME}/.bashrc \
    && echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> /home/${USERNAME}/.bashrc \
    && echo 'eval "$(pyenv init -)"' >> /home/${USERNAME}/.bashrc \
    && echo PS1="'"'\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\ \033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '"'" >>  /home/${USERNAME}/.bashrc

USER ${USERNAME}

VOLUME /home/${USERNAME}/.vscode-server