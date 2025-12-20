FROM elixir:1.17.3-otp-27

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NOWARNINGS yes

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install git vim sudo inotify-tools mariadb-client

RUN curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -

RUN apt-get -y install nodejs && npm install -g npm

# prerequisites
RUN apt-get update && apt-get -y install ca-certificates curl gnupg

# add PGDG repository key (keyring)
RUN install -d /usr/share/postgresql-common/pgdg \
 && curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc \
    | gpg --dearmor -o /usr/share/postgresql-common/pgdg/pgdg.gpg

# add PGDG repository (bookworm 固定。lsb_release不要)
RUN echo "deb [signed-by=/usr/share/postgresql-common/pgdg/pgdg.gpg] http://apt.postgresql.org/pub/repos/apt bookworm-pgdg main" \
    > /etc/apt/sources.list.d/pgdg.list

# install latest client from PGDG
RUN apt-get update \
 && apt-get -y install postgresql-client \
 && psql --version

ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID devel
RUN useradd -u $UID -g devel -m devel
RUN echo "devel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY --chown=devel:devel ./apps /apps

USER devel

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install --force hex phx_new 1.8.0

RUN echo alias \
  elixirc=\"/usr/local/bin/elixirc --ignore-module-conflict\" \
  >> /home/devel/.bash_aliases
