# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.148.0/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] https://hub.docker.com/r/google/cloud-sdk/tags
ARG VARIANT="latest"
# [choice] https://hub.docker.com/r/hashicorp/terraform/tags
ARG TERRAFORM_VERSION="0.13.5"

FROM hashicorp/terraform:${TERRAFORM_VERSION} AS terraform-builder
FROM google/cloud-sdk:${VARIANT}

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid $USER_UID --gid ${USER_GID} -m ${USERNAME} \
    && apt-get update \
    && apt-get install -y sudo wget unzip vim \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/${USERNAME} \
    && mkdir /home/$USERNAME/.ssh \
    && chmod 700 /home/${USERNAME}/.ssh \
    && chown $USERNAME: /home/$USERNAME/.ssh

# Copy terraform from official image - change the version if required (unfortunately ARG can't be used here)
COPY --from=terraform-builder /bin/terraform /usr/local/bin/terraform

# Copy terraform-docs from official image
COPY --from=quay.io/terraform-docs/terraform-docs:latest /usr/local/bin/terraform-docs /usr/local/bin/terraform-docs

# Install latest tflint
RUN curl -L "$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip \
    && unzip tflint.zip \
    && rm tflint.zip \
    && mv tflint /usr/local/bin/

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME

# Default powerline10k theme, no plugins installed
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
    -p git -p ssh-agent -p 'history-substring-search' \
    -a 'bindkey "\$terminfo[kcuu1]" history-substring-search-up' \
    -a 'bindkey "\$terminfo[kcud1]" history-substring-search-down'
