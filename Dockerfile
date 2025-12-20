FROM elixir:1.17.3-otp-27

ENV DEBIAN_FRONTEND=noninteractive

# base tools + NodeSource prereqs
RUN apt-get update \
 && apt-get -y install --no-install-recommends \
      git vim inotify-tools mariadb-client \
      ca-certificates curl gnupg \
 && rm -rf /var/lib/apt/lists/*

# Node.js 20 (NodeSource)  ※sudo不要
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
 && apt-get update \
 && apt-get -y install --no-install-recommends nodejs \
 && node -v && npm -v \
 && rm -rf /var/lib/apt/lists/*

# PGDG keyring + repo + latest PostgreSQL client
RUN install -d /usr/share/postgresql-common/pgdg \
 && curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc \
    | gpg --dearmor -o /usr/share/postgresql-common/pgdg/pgdg.gpg \
 && echo "deb [signed-by=/usr/share/postgresql-common/pgdg/pgdg.gpg] http://apt.postgresql.org/pub/repos/apt bookworm-pgdg main" \
    > /etc/apt/sources.list.d/pgdg.list \
 && apt-get update \
 && apt-get -y install --no-install-recommends postgresql-client \
 && psql --version \
 && rm -rf /var/lib/apt/lists/*

ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID devel \
 && useradd -u $UID -g devel -m devel \
 && echo "devel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY --chown=devel:devel ./apps /apps

USER devel

RUN mix local.hex --force \
 && mix local.rebar --force \
 && mix archive.install --force hex phx_new 1.8.0

RUN echo 'alias elixirc="/usr/local/bin/elixirc --ignore-module-conflict"' \
  >> /home/devel/.bash_aliases