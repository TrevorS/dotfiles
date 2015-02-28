# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# personal settings loaded before oh-my-zsh
if [[ -a ~/.personal.before.rc ]]; then
  source ~/.personal.before.rc
fi

# Set name of the theme to load.
ZSH_THEME="robbyrussell"

# zsh plugins
plugins=(git rails ruby rake rbenv bundler mvn ssh-agent tmux)

# turn off auto-updating, it will be handled by .dotfiles
DISABLE_AUTO_UPDATE=true

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# personal settings loaded after oh-my-zsh
if [[ -a ~/.personal.after.rc ]]; then
  source ~/.personal.after.rc
fi

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-ocean.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# set vim as the default editor
export EDITOR=vim

# vi mode
bindkey -v
bindkey jj vi-cmd-mode

# recover the readline keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^N" history-search-forward
bindkey "^F" forward-char
bindkey "^B" backward-char

# git undo last commit alias
alias git-undo="git reset --soft 'HEAD^'"

# take me to my git home
alias git-home='cd "$(git rev-parse --show-toplevel)"'

# git difftool aliases
alias gdt='git difftool'
alias gdtc='git difftool --cached'

# git add from pattern using ag
function ag-git-add() {
  ag --nocolor --null --files-with-matches "$*" | xargs -0 git add
}
alias aga=ag-git-add

# ls aliases
alias l='ls'
alias la='ls -la'
alias lah='ls -lah'

# use ./bin when it's safe (useful for Spring / tim pope's suggestion)
PATH=".git/safe/../../bin:$PATH"

# add node_modules/.bin to the path
PATH="$HOME/node_modules/.bin:$PATH"

# Change less to ignore case, show colors, and improve the prompt
export LESS='-iR-P%f (%i/%m) Line %lt/%L'

# reload .zshrc
alias reload!='. ~/.zshrc'
