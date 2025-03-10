export ZSH="$ZDOTDIR/ohmyzsh"
ZSH_THEME="typewritten"

plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# User specific
source ~/.config/zsh/custom/zshrc

# Enable chruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby ruby-3.4.1

# Custom aliases
alias vim='nvim'
alias ls='ls -alG'
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias flutterprojects='cd ~/Documents/Projects/flutter/'
alias gleamprojects='cd ~/Documents/Projects/gleam/'
alias dartprojects='cd ~/Documents/Projects/dart/'
alias luaprojects='cd ~/Documents/Projects/lua/'

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/rafaelqvin/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/rafaelqvin/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/rafaelqvin/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/rafaelqvin/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
