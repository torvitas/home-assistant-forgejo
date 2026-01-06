#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

bashio::log.info "Ensure permission..."
chown git:git "$GITEA_CUSTOM" "${GITEA_TEMP}"

bashio::log.info "Render configuration..."
exec /usr/local/bin/docker-setup.sh

bashio::log.info "Starting forgejo..."
exec gosu git /app/gitea/gitea $(bashio::config "arguments")
