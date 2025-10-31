export ZSH="$HOME/.oh-my-zsh/"
ZSH_THEME="typewritten"

plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# User specific
source ~/.config/zsh/custom/zshrc

# Custom aliases
alias vim='nvim'
alias ls='ls -alG'
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias flutterprojects='cd ~/Documents/projects/flutter/'
# alias gleamprojects='cd ~/Documents/projects/gleam/'
alias dartprojects='cd ~/Documents/projects/dart/'
# alias luaprojects='cd ~/Documents/projects/lua/'

# Multi-user brew support
unalias brew 2>/dev/null
brewser=$(stat -f "%Su" $(which brew))
alias brew='sudo -Hu '$brewser' brew'


# Config aliases
alias zshconfig='nvim ~/.config/zsh/.zshrc'
alias envconfig='nvim ~/.config/zsh/.zshenv'
alias aeroconfig='nvim ~/.config/aerospace/aerospace.toml'
alias vimconfig='nvim ~/.config/nvim/init.lua'

fpath+=${ZDOTDIR:-~}/.zsh_functions

echo "      _        _        _
    >(.)__   =(.)__   =(.)__
     (___/    (___/    (___/   

        去年がウソみたい。 
       "

# Revisit this
# compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
