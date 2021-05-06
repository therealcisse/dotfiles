# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="amsayk"
# ZSH_THEME="robbyrussell"

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
# ENABLE_CORRECTION="true"

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

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.zsh/oh-my-zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
if [ `uname` = 'Darwin' ]; then
  plugins=(zsh-autosuggestions)
else
  plugins=(zsh-autosuggestions)
fi

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias sudo='nocorrect sudo'

#
# History
#

export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

source $HOME/.zsh/aliases
source $HOME/.zsh/common
source $HOME/.zsh/colors
source $HOME/.zsh/exports
source $HOME/.zsh/functions
source $HOME/.zsh/path
source $HOME/.zsh/vars

test -e $HOME/.zsh/common.private && source $HOME/.zsh/common.private
test -e $HOME/.zsh/functions.private && source $HOME/.zsh/functions.private

# tmux unsets this and then xclip gets confused
if [ -n "$DISPLAY" ]; then
  export DISPLAY=:0
fi

#
# Hooks
#

autoload -U add-zsh-hook

function set-tab-and-window-title() {
  emulate -L zsh
  local CMD="${1:gs/$/\\$}"
  print -Pn "\e]0;$CMD:q\a"
}

function update-window-title-precmd() {
  emulate -L zsh
  set-tab-and-window-title `history | tail -1 | cut -b8-`
}
add-zsh-hook precmd update-window-title-precmd

function update-window-title-preexec() {
  emulate -L zsh
  setopt extended_glob

  # skip ENV=settings, sudo, ssh; show first distinctive word of command;
  # mostly stolen from:
  #   https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/termsupport.zsh
  set-tab-and-window-title ${2[(wr)^(*=*|ssh|sudo)]}
}
add-zsh-hook preexec update-window-title-preexec

HOST_RC=$HOME/.zsh/host/$(hostname -s)
test -f $HOST_RC && source $HOST_RC

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# add rust cargo bin to path
test -e $RUSTPATH && source $RUSTPATH/env

LOCAL_RC=$HOME/.zshrc.local
test -f $LOCAL_RC && source $LOCAL_RC

# Load the fast-syntax-highlighting plugin
if [ -f $ZSH_CUSTOM/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]
then
  source $ZSH_CUSTOM/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

  # Enable highlighters
  # ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

  # Override highlighter colors
  # ZSH_HIGHLIGHT_STYLES[default]=none
  # ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
  # ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
  # ZSH_HIGHLIGHT_STYLES[alias]=fg=white,bold
  # ZSH_HIGHLIGHT_STYLES[builtin]=fg=white,bold
  # ZSH_HIGHLIGHT_STYLES[function]=fg=white,bold
  # ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
  # ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
  # ZSH_HIGHLIGHT_STYLES[commandseparator]=none
  # ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
  # ZSH_HIGHLIGHT_STYLES[path]=fg=214,underline
  # ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
  # ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
  # ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
  # ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
  # ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
  # ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
  # ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
  # ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
  # ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
  # ZSH_HIGHLIGHT_STYLES[assign]=none
fi

# export PATH=/usr/local/opt/sbt@0.13/bin/:$PATH


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

export PATH="/usr/local/opt/ruby/bin:$PATH"

# export SBT_OPTS="-Xmx4096M -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=2G -Xss2M"

export MOBILE_SDK_SITE_PASSWORD=geekdroid
export DI_INTERNAL_API_USERNAME=deviceident
export DI_INTERNAL_API_PASSWORD=V5PJTQmZxb4jRWbFRD-530-j

export BROWSERSTACK_USERNAME=diopmon1
export BROWSERSTACK_PASSWORD=VqV9yzXjQsAqxxyhuHpR

export DEMOPAGE_CBT_TESTINGBOT_KEY=2eea7ec7f847ac885f48aa6c5f236492
export DEMOPAGE_CBT_TESTINGBOT_SECRET=89ecaa3ee6a121385d0ac1a2bb404b89

unsetopt inc_append_history
unsetopt share_history

# export SBT_OPTS="-XX:+UseG1GC $SBT_OPTS"
