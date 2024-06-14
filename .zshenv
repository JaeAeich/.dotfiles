export USER="$(whoami)"

# Check if HOME is set, if not, set it to the default value.
if [[ -z "$HOME" ]]; then
    export HOME="/home/$USER"
fi

# Workaround needed for testing
export LC_ALL=en_US.UTF-8 

# XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Set other application configuration based on XDG directory
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
export ANSIBLE_HOME="${XDG_CONFIG_HOME}/ansible"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible.cfg"
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy_cache"