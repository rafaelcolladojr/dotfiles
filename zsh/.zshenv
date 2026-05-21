export TERM="${TERM:-xterm-256color}"
export EDITOR="nvim"

export ZSH_DISABLE_COMPFIX="true"

# User specific (per-machine; file is gitignored — see custom/)
[ -f ~/.config/zsh/custom/zshenv ] && source ~/.config/zsh/custom/zshenv

export DART_SDK="$HOME/Documents/development/flutter/bin"

# Clean up the $HOME
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_RUNTIME_DIR=/run/user/"$UID"
export ZSH_CUSTOM="$XDG_CONFIG_HOME/zsh/custom"
# export ANDROID_HOME="$XDG_DATA_HOME"/android
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GEM_HOME="$HOME/.gem"
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
[ -d /Applications/Ghostty.app/Contents/Resources/terminfo ] && export TERMINFO_DIRS="$TERMINFO_DIRS:/Applications/Ghostty.app/Contents/Resources/terminfo"

export CUSTOM_SCRIPTS_DIR="$HOME/Documents/scripts"

# Homebrew (macOS) — prepend if present
[ -d /opt/homebrew/bin ] && export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt:$PATH"

# User-local bin (Linux convention) — prepend if present
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

export PATH="$PATH:$DART_SDK:$HOME/Documents/development/scripts/:$HOME/.pub-cache/bin/:$CUSTOM_SCRIPTS_DIR"
