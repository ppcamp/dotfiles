# FIXME: not working properly
# its just a wrapper to avoid gopass everytime or even keep exposed the pass
#
ENV_MEM_CACHE="/dev/shm/env_${USER}"
load_env_cached() {
  if [[ ! -f $ENV_MEM_CACHE ]]; then
    # load the env vars and cache them in memory for faster access
    source "$HOME/.env"
    export -p >"$ENV_MEM_CACHE"
    # avoid other users to read the env cache
    chmod 600 "$ENV_MEM_CACHE"
  fi

  source "$ENV_MEM_CACHE"
}

env_reload() {
  rm -f "$ENV_MEM_CACHE"
  load_env_cached
}
