FROM alpine:3.19

WORKDIR /dbt

ARG SSH_PORT=22

RUN apk update \
    && apk add --no-cache \
        curl \
        git \
        zsh \
        bash \
    && git clone http://github.com/aaweaver-actuary/dotfiles \
    && mv ./dotfiles/install_dotfiles /usr/bin/install_dotfiles \
    && chmod +x /usr/bin/install_dotfiles \
    && rm -rf ./dotfiles \
    && install_dotfiles /dbt install_alpine_dbt \
                             install_duckdb \
                             install_snowsql \
                             install_alpine_ssh \
    && chmod +x /dbt/install_alpine_dbt \
                /dbt/install_duckdb \
                /dbt/install_snowsql \
                /dbt/install_alpine_ssh \
    && /dbt/install_alpine_dbt \
    && /dbt/install_duckdb \
    && /dbt/install_snowsql \
    && /dbt/install_alpine_ssh \
    && rm install_alpine_dbt install_duckdb install_snowsql install_alpine_ssh \
    && apk add --no-cache zsh-vcs \
    && install_dotfiles ~ install_oh_my_zsh \
    && chmod +x ~/install_oh_my_zsh \
    && . ~/install_oh_my_zsh \
    && rm ~/install_oh_my_zsh \
    && install_dotfiles ~ .vimrc .passwords \
    && exec zsh \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && touch ~/.passwords \
    && rm -rf /dbt/dbt_project

  EXPOSE $SSH_PORT

  SHELL ["/bin/zsh", "-c"]

  CMD ["/usr/sbin/sshd", "-D"]
