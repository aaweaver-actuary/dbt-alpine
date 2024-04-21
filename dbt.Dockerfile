FROM mcr.microsoft.com/devcontainers/python:1-3.12-bullseye

WORKDIR /dbt

COPY ./on-container-start /dbt/on-container-start

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get full-upgrade -y \
    && apt-get install \
        curl \
        git \
        zsh \
        bash \
\
    && git clone http://github.com/aaweaver-actuary/dotfiles \
    && mv ./dotfiles/install_dotfiles /usr/bin/install_dotfiles \
    && chmod +x /usr/bin/install_dotfiles \
    && rm -rf ./dotfiles \
\
    && install_dotfiles /dbt install_dbt \
                             install_duckdb \
                             install_snowsql \
                             install_nvim \
    && chmod +x /dbt/install_dbt \
                /dbt/install_duckdb \
                /dbt/install_snowsql \
                /dbt/install_nvim \
    && /dbt/install_dbt \
    && /dbt/install_duckdb \
    && /dbt/install_snowsql \
    && /dbt/install_nvim \
    && rm install_dbt install_duckdb install_snowsql install_nvim \
\
    && apt-get install curl -y \
    && exec zsh \
    && install_dotfiles ~ install_oh_my_zsh \    
    && chmod +x ~/install_oh_my_zsh \
    && . ~/install_oh_my_zsh \
    && rm ~/install_oh_my_zsh \
\
    && install_dotfiles ~ .zshrc .zsh_aliases .vimrc .passwords \
    && exec zsh \
    && touch ~/.passwords \
    && rm -rf /dbt/dbt_project \
\
    && apt-get autoremove -y \
    && apt-get clean -y \
    && apt-get autoclean -y \
\
    && exec zsh 

SHELL ["/bin/zsh", "-c"]

ENTRYPOINT ["/dbt/on-container-start"]

CMD sleep infinity
