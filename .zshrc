# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# personal settings loaded before oh-my-zsh
if [[ -a ~/.personal.before.rc ]]; then
  source ~/.personal.before.rc
fi

# Set name of the theme to load.
ZSH_THEME="pure"

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

# make path changes
if [[ -z $TMUX ]]; then
  # rbenv
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"

  # use ./bin when it's safe (useful for Spring / tim pope's suggestion)
  PATH=".git/safe/../../bin:$PATH"

  # add node_modules/.bin to the path
  PATH="$HOME/node_modules/.bin:$PATH"
fi

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# set vim as the default editor
export EDITOR=nvim

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

# ls aliases
alias l='ls'
alias la='ls -la'
alias lah='ls -lah'

# git undo last commit alias
alias git-undo="git reset --soft 'HEAD^'"

# git difftool aliases
alias gdt='git difftool'
alias gdtc='git difftool --cached'

# git alias to sort branches by recently updated
alias gbs='git for-each-ref --sort=committerdate refs/heads/ \
  --format="%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))"'

# git add from pattern using ag
function ag-git-add() {
  ag --nocolor --null --files-with-matches "$*" | xargs -0 git add
}
alias aga=ag-git-add

function git-heroku-commit() {
  git ls-remote $1 | awk 'END{print $1}' | xargs git show
}
alias ghc=git-heroku-commit

# Change less to ignore case, show colors, and improve the prompt
export LESS='-iR-P%f (%i/%m) Line %lt/%L'

# reload .zshrc
alias reload!='. ~/.zshrc'

# take me to my git home
alias git-home='cd "$(find-git-home)"'

# find git home directory
function find-git-home() {
  git rev-parse --show-toplevel
}

# find the filename of the last migration based on file timestamp
function last-migration() {
  ls -rt `find "$(find-git-home)/db/migrate" -type f -name "*" -print` | tail -1
}

alias vlmg='vim "$(last-migration)"'

function heroku-database-credentials() {
  heroku pg:credentials $1 --app $2 | tail -n 1 | tr -d ' '
}

function heroku-pgcli() {
  pgcli $(heroku-database-credentials $1 $2)
}

alias hpg=heroku-pgcli
alias vim=nvim
alias gdc='git diff --cached'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
