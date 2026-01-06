#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

bashio::log.info "Starting forgejo..."

exec /app/gitea/gitea $(bashio::config "arguments")
