#!/bin/bash

set -e

ME=$(basename "$0")

entrypoint_log() {
    if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
        echo "$@"
    fi
}

# Adapted from 20-envsubst-on-templates.sh
auto_jinja() {
  local template_dir="${NGINX_JINJA_TEMPLATE_DIR:-/etc/nginx/templates}"
  local suffix="${NGINX_JINJA_TEMPLATE_SUFFIX:-.jinja}"
  local output_dir="${NGINX_JINJA_OUTPUT_DIR:-/etc/nginx/conf.d}"

  local template relative_path output_path subdir
  [ -d "$template_dir" ] || return 0
  if [ ! -w "$output_dir" ]; then
    entrypoint_log "$ME: ERROR: $template_dir exists, but $output_dir is not writable"
    return 0
  fi
  find "$template_dir" -follow -type f -name "*$suffix" -print | while read -r template; do
    relative_path="${template#$template_dir/}"
    output_path="$output_dir/${relative_path%$suffix}"
    subdir=$(dirname "$relative_path")
    mkdir -p "$output_dir/$subdir"
    entrypoint_log "$ME: Running jinjanate (jinja template) on $template to $output_path"
    jinjanate --quiet --undefined --output-file "$output_path" "$template"
  done
}

auto_jinja
