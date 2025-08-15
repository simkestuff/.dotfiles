# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

# User configuration

# History file for zsh
HISTFILE=~/.zsh_history

# How many commands to store in history
HISTSIZE=10000
SAVEHIST=10000

# Share history in every terminal session
setopt SHARE_HISTORY

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# set  emacs mode
bindkey -e

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR=vim
else
  export EDITOR=nvim
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# set dark mode (nvim -> theme)
dark() {
    export MYTHEME="dark"
    sed -i 's/^vim.o.background = \".*\"$/vim.o.background = \"dark\"/g' $HOME/.config/nvim/lua/sinisa/options-after.lua
}

# set light mode (nvim -> theme)
light() {
    export MYTHEME="light"
    sed -i 's/^vim.o.background = \".*\"$/vim.o.background = \"light"/g' $HOME/.config/nvim/lua/sinisa/options-after.lua
}

# golang
export PATH=$PATH:$HOME/go/bin
# export GOPATH=~/go
# export GOROOT=/usr/local/go
# export GOBIN=$GOPATH/bin

# haskell
[ -f "/home/sinisa/.ghcup/env" ] && source "/home/sinisa/.ghcup/env" # ghcup-env

# keybinding za pokretanje tmux-sessionizer
bindkey -s "^p" "/usr/local/bin/tmux-sessionizer\n"

# opam configuration
[[ ! -r /home/sinisa/.opam/opam-init/init.zsh ]] || source /home/sinisa/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# ovo je da se ispravno prikaže virt env kod ulaska u direktorij
setopt PROMPT_SUBST

show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
PS1='$(show_virtual_env)'$PS1

# ovo je zbog pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# poetry autocompletion
fpath+=~/.zfunc
autoload -Uz compinit && compinit

eval "$(zoxide init zsh)"
alias cd="z"
#
# dodano zbog direnv alata; treba biti zadnja linija fajle?
eval "$(direnv hook zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# starship
eval "$(starship init zsh)"
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# zig
export PATH=/opt/zig-linux-x86_64-0.13.0:$PATH

# doom emacs
export PATH=/home/sinisa/.config/emacs/bin/:$PATH
