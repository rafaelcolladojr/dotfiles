[ -f .customsrc ] && source .customsrc

# Custom aliases
alias vim='nvim'
alias ls='ls -alG'
alias brew='/opt/homebrew/bin/brew'
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias python=python3
alias nvimedit='cd ~/.config/nvim; vim'
alias flutterprojects='cd ~/Documents/Projects/flutter/'
alias luaprojects='cd ~/Documents/Projects/lua/'

# Config aliases
alias zshconfig='nvim ~/.config/zsh/.zshrc'
alias envconfig='nvim ~/.config/zsh/.zshenv'
alias yabaiconfig='nvim ~/.config/yabai/yabairc'
alias skhdconfig='nvim ~/.config/skhd/skhdrc'
alias alacrittyconfig='nvim ~/.config/alacritty/alacritty.yml'

fpath+=${ZDOTDIR:-~}/.zsh_functions

# Typewritten zsh theme
export TYPEWRITTEN_PROMPT_LAYOUT="singleline"
export TYPEWRITTEN_SYMBOL="❯"
export TYPEWRITTEN_ARROW_SYMBOL="->"
export TYPEWRITTEN_RELATIVE_PATH="adaptive"
export TYPEWRITTEN_CURSOR="underscore"
export TYPEWRITTEN_RIGHT_PROMPT_PREFIX=""

fpath+=$HOME/.zsh/typewritten
autoload -U promptinit; promptinit
prompt typewritten

echo "      _        _        _
    >(.)__   =(.)__   =(.)__
     (___/    (___/    (___/   

        去年がウソみたい。 
       "

# Revisit this
# compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

