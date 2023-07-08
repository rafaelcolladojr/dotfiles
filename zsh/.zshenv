export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin:$HOME/Documents/development/flutter/bin/:/Library/Java/JavaVirtualMachines/jdk-15.0.2.jdk/Contents/Home/bin:$HOME/development/scripts/:$HOME/.pub-cache/bin/"

export EDITOR="nvim"

export ZSH_DISABLE_COMPFIX="true"

# Clean up the $HOME
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_RUNTIME_DIR=/run/user/"$UID"
export ZSH_CUSTOM="$XDG_CONFIG_HOME/zsh/custom"
# export ANDROID_HOME="$XDG_DATA_HOME"/android
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
