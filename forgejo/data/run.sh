#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

bashio::log.info "Starting forgejo..."

chown git:git "$GITEA_CUSTOM" "${GITEA_TEMP}"

exec gosu git /usr/local/bin/docker-setup.sh
exec gosu git /app/gitea/gitea $(bashio::config "arguments")
