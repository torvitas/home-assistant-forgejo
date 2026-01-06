#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

bashio::log.info "Starting forgejo..."

chown git:git "$GITEA_CUSTOM"

exec gosu git /app/gitea/gitea $(bashio::config "arguments")
