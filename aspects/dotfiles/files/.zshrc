# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM=alacritty

# # Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -A __TRC

__TRC[ITALIC_ON]=$'\e[3m'
__TRC[ITALIC_OFF]=$'\e[23m'

#
# Teh H4xx
#

if [ "$(uname)" = "Darwin" ]; then
  # Suppress unwanted Homebrew-installed stuff.
  if [ -e /usr/local/share/zsh/site-functions/_git ]; then
    mv -f /usr/local/share/zsh/site-functions/{,disabled.}_git
  fi

  # Set 60 fps key repeat rate
  #
  # Equivalent to the fatest rate acheivable with:
  #
  #     defaults write NSGlobalDomain KeyRepeat -int 1
  #
  # But doesn't require a logout and will get restored every time we open a
  # shell (for example, if somebody manipulates the slider in the UI).
  #
  # Fastest rate available from UI corresponds to:
  #
  #     defaults write NSGlobalDomain KeyRepeat -int 2
  #
  # Slowest rate available from UI corresponds to:
  #
  #     defaults write NSGlobalDomain KeyRepeat -int 120
  #
  # Values at each slider position in UI, from slowest to fastest:
  #
  # - 120 -> 2 seconds (ie. .5 fps)
  # - 90 -> 1.5 seconds (ie .6666 fps)
  # - 60 -> 1 second (ie 1 fps)
  # - 30 -> 0.5 seconds (ie. 2 fps)
  # - 12 -> 0.2 seconds (ie. 5 fps)
  # - 6 -> 0.1 seconds (ie. 10 fps)
  # - 2 -> 0.03333 seconds (ie. 30 fps)
  #
  # See: https://github.com/mathiasbynens/dotfiles/issues/687
  #
  if command -v dry &> /dev/null; then
    dry 0.0166666666667 > /dev/null
  fi
fi


#
# Completion
#

fpath=($HOME/.zsh/completions $fpath)

autoload -U compinit
compinit -u


# Make completion:
# - Try exact (case-sensitive) match first.
# - Then fall back to case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''

# Allow completion of ..<Tab> to ../ and beyond.
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(..) ]] && reply=(..)'

# $CDPATH is overpowered (can allow us to jump to 100s of directories) so tends
# to dominate completion; exclude path-directories from the tag-order so that
# they will only be used as a fallback if no completions are found.
zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'

# Categorize completion suggestions with headings:
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{default}%B%{$__TRC[ITALIC_ON]%}--- %d ---%{$__TRC[ITALIC_OFF]%}%b%f

# Enable keyboard navigation of completions in menu
# (not just tab/shift-tab but cursor keys as well):
zstyle ':completion:*' menu select

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="therealcisse"
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

plugins=(
  git
  kubectl
  # dotenv
  macos
  aws
  docker
  localstack
  kops
  k9s
  git-extras
  git-commit
  gcloud
  # flutter
)

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.zsh/oh-my-zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"


# Pathogen-like loader for plugins
find -L ~/.zsh/bundle -type f -name "*.plugin.zsh" | sort | while read filename; do source "$filename"; done

export DISABLE_AUTO_TITLE='true'

#
# Bindings
#

autoload -U select-word-style
select-word-style bash # only alphanumeric chars are considered WORDCHARS

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

bindkey ' ' magic-space # do history expansion on space

bindkey "\e[1;5D" backward-word # Ctrl + <letf>
bindkey "\e[1;5C" forward-word  # Ctrl + <right>

bindkey \^u backward-kill-line

# Switch back and forward between program faster

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

if [ "$(uname)" = "Darwin" ]; then
  # Suppress unwanted Homebrew-installed stuff.
  if [ -e /usr/local/share/zsh/site-functions/_git ]; then
    mv -f /usr/local/share/zsh/site-functions/{,disabled.}_git
  fi
fi

#
# Correction
#

# exceptions to auto-correction
alias bundle='nocorrect bundle'
alias cabal='nocorrect cabal'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias stack='nocorrect stack'
alias sudo='nocorrect sudo'

#
# Prompt
#

autoload -U colors
colors

# History

export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

#
# Options
#

setopt AUTO_CD                 # [default] .. is shortcut for cd .. (etc)
setopt AUTO_PARAM_SLASH        # tab completing directory appends a slash
setopt AUTO_PUSHD              # [default] cd automatically pushes old dir onto dir stack
setopt AUTO_RESUME             # allow simple commands to resume backgrounded jobs
setopt CLOBBER                 # allow clobbering with >, no need to use >!
setopt CORRECT                 # [default] command auto-correction
setopt CORRECT_ALL             # [default] argument auto-correction
setopt NO_FLOW_CONTROL         # disable start (C-s) and stop (C-q) characters
setopt NO_HIST_IGNORE_ALL_DUPS # don't filter non-contiguous duplicates from history
setopt HIST_FIND_NO_DUPS       # don't show dupes when searching
setopt HIST_IGNORE_DUPS        # do filter contiguous duplicates from history
setopt HIST_IGNORE_SPACE       # [default] don't record commands starting with a space
setopt HIST_VERIFY             # confirm history expansion (!$, !!, !foo)
setopt IGNORE_EOF              # [default] prevent accidental C-d from exiting shell
setopt INTERACTIVE_COMMENTS    # [default] allow comments, even in interactive shells
setopt LIST_PACKED             # make completion lists more densely packed
setopt MENU_COMPLETE           # auto-insert first possible ambiguous completion
setopt NO_NOMATCH              # [default] unmatched patterns are left unchanged
setopt PRINT_EXIT_VALUE        # [default] for non-zero exit status
setopt PUSHD_IGNORE_DUPS       # don't push multiple copies of same dir onto stack
setopt PUSHD_SILENT            # [default] don't print dir stack after pushing/popping
setopt SHARE_HISTORY           # share history across shells


#
# Plug-ins
#

# NOTE: must come before zsh-history-substring-search & zsh-syntax-highlighting.
autoload -U select-word-style
select-word-style bash # only alphanumeric chars are considered WORDCHARS

source ~/.zsh/oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

bindkey '^i' autosuggest-accept

# NOTE: must come after select-word-style.
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

# Note that this will only ensure unique history if we supply a prefix
# before hitting "up" (ie. we perform a "search"). HIST_FIND_NO_DUPS
# won't prevent dupes from appearing when just hitting "up" without a
# prefix (ie. that's "zle up-line-or-history" and not classified as a
# "search"). So, we have HIST_IGNORE_DUPS to make life bearable for that
# case.
#
# https://superuser.com/a/1494647/322531
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# Uncomment this to get syntax highlighting:
# NOTE: must come after select-word-style.
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#
# Bindings
#

bindkey -e # emacs bindings, set to -v for vi bindings

# Use "cbt" capability ("back_tab", as per `man terminfo`), if we have it:
if tput cbt &> /dev/null; then
  bindkey "$(tput cbt)" reverse-menu-complete # make Shift-tab go to previous completion
fi


if [[ $(uname -a) =~ "Ubuntu" ]]; then
  bindkey "$key[Up]" history-substring-search-up
  bindkey "$key[Down]" history-substring-search-down
else
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

bindkey ' ' magic-space # do history expansion on space

# Replace standard history-incremental-search-{backward,forward} bindings.
# These are the same but permit patterns (eg. a*b) to be used.
bindkey "^r" history-incremental-pattern-search-backward
bindkey "^s" history-incremental-pattern-search-forward

# Make CTRL-Z background things and unbackground them.
function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N fg-bg
bindkey '^Z' fg-bg

# Mac-like wordwise movement (Opt/Super plus left/right) in Kitty.
bindkey "^[[1;3C" forward-word # For macOS.
bindkey "^[[1;3D" backward-word # For macOS.
bindkey "^[[1;5C" forward-word # For Arch.
bindkey "^[[1;5D" backward-word # For Arch.

#
# Other prerequisites before we set up `$PATH`.
#

test -d $HOME/n && export N_PREFIX="$HOME/n"

#
# Other
#

source $HOME/.zsh/path # Must come first! (Others depend on it.)

source $HOME/.zsh/aliases
source $HOME/.zsh/common
source $HOME/.zsh/colors
source $HOME/.zsh/exports
source $HOME/.zsh/functions
source $HOME/.zsh/vars

test -e $HOME/.zsh/common.private && source $HOME/.zsh/common.private
test -e $HOME/.zsh/functions.private && source $HOME/.zsh/functions.private

# tmux unsets this and then xclip gets confused
if [ -n "$DISPLAY" ]; then
  export DISPLAY=:0
fi

# Local and host-specific overrides.

LOCAL_RC=$HOME/.zshrc.local
test -f $LOCAL_RC && source $LOCAL_RC

HOST_RC=$HOME/.zsh/host/$(hostname -s)
test -f $HOST_RC && source $HOST_RC

export DISABLE_UPDATE_PROMPT=false

setopt inc_append_history
setopt share_history

export LOCAL_METRICS_ENABLED=true

#
# /etc/motd
#

if [ -e /etc/motd ]; then
  if ! cmp -s $HOME/.hushlogin /etc/motd; then
    tee $HOME/.hushlogin < /etc/motd
  fi
fi

alias java21="export JAVA_HOME=`/usr/libexec/java_home -v 21`"
alias java11="export JAVA_HOME=`/usr/libexec/java_home -v 11`"
alias java17="export JAVA_HOME=`/usr/libexec/java_home -v 17`"

# export NODE_OPTIONS=--openssl-legacy-provider

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(direnv hook zsh)"

if [ -d "$HOME/.zshenv.d" ]; then
  for EXTENSION_FILE in $(find $HOME/.zshenv.d/ -name '*.zsh'); do
    source "$EXTENSION_FILE"
  done
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
