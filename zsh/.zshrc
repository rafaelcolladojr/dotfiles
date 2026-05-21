export ZSH="$HOME/.oh-my-zsh/"
ZSH_THEME="typewritten"

# Double the prompt symbol in SSH sessions as a visual indicator
if [[ -n "$SSH_CONNECTION" || -n "$SSH_CLIENT" || -n "$SSH_TTY" ]]; then
  TYPEWRITTEN_SYMBOL="❯❯"
fi

plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# User specific (per-machine; file is gitignored — see custom/)
[ -f ~/.config/zsh/custom/zshrc ] && source ~/.config/zsh/custom/zshrc

# Custom aliases
alias vim='nvim'
# GNU ls uses --color=auto; BSD ls (macOS) uses -G
if ls --color=auto / >/dev/null 2>&1; then
  alias ls='ls -al --color=auto'
else
  alias ls='ls -alG'
fi
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias flutterprojects='cd ~/Documents/projects/flutter/'
# alias gleamprojects='cd ~/Documents/projects/gleam/'
alias dartprojects='cd ~/Documents/projects/dart/'
# alias luaprojects='cd ~/Documents/projects/lua/'

# Multi-user brew support (macOS only — brew may be owned by a different user)
if command -v brew >/dev/null 2>&1 && [[ "$OSTYPE" == darwin* ]]; then
  unalias brew 2>/dev/null
  brewser=$(stat -f "%Su" "$(which brew)")
  alias brew='sudo -Hu '$brewser' brew'
fi


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
