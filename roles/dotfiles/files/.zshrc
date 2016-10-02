# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="terminalparty"

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
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(osx npm)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

# export NVM_DIR="$HOME/.nvm"
# # alias loadnvm="[ -s "$NVM_DIR/nvm.sh" ] && . $NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

test -e "$HOME/Library/Android/sdk" && export ANDROID_HOME=$HOME/Library/Android/sdk

alias play=activator

test -e "$HOME/.bin" && export PATH=$PATH:$HOME/.bin

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

export DISABLE_AUTO_TITLE='true'

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

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

# BASE16_SHELL=$HOME/.base16-shell
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

#
# Colors
#

BASE16_DIR=$HOME/.base16-shell
BASE16_CONFIG=$HOME/.base16

color() {
  BACKGROUND="$1"
  SCHEME="$2"

  if [ $# -eq 0 -a -s "$BASE16_CONFIG" ]; then
    cat $BASE16_CONFIG
    return
  fi

  if [[ "$SCHEME" = 'help' ]]; then
    BACKGROUND='help'
  fi

  case "$BACKGROUND" in
  dark|light)
    if [[ -x "$BASE16_DIR/scripts/base16-$SCHEME-$BACKGROUND.sh" ]]; then
      echo "$SCHEME" >! "$BASE16_CONFIG"
      echo "$BACKGROUND" >> "$BASE16_CONFIG"
      "$BASE16_DIR/scripts/base16-$SCHEME-$BACKGROUND.sh"
    elif [[ -x "$BASE16_DIR/scripts/base16-$THEME.sh" ]]; then
      echo "$SCHEME" >! "$BASE16_CONFIG"
      echo dark >> "$BASE16_CONFIG"
      "$BASE16_DIR/scripts/base16-$THEME.sh"
    else
      echo "Scheme '$SCHEME' not found in $BASE16_DIR"
      return 1
    fi
    ;;
  help)
    echo 'color dark [ocean|grayscale|ashes|default|railscasts|tomorrow|twilight|...]'
    echo 'color light [grayscale|harmonic16|ocean|tomorrow|twilight|...]'
    echo
    echo 'Available schemes:'
    find "$BASE16_DIR/scripts/" -name 'base16-*.sh' | \
      sed -E 's|.+/base16-||' | \
      sed -E 's/\.(dark|light)\.sh/ (\1)/' | \
      column
      ;;

  *)
    echo 'Unknown subcommand: use one of {dark,light,help}'
    ;;
  esac

}

dark() {
  color dark "$1"
}

light() {
  color light "$1"
}

if [[ -s "$BASE16_CONFIG" ]]; then
  SCHEME=$(head -1 "$BASE16_CONFIG")
  BACKGROUND=$(sed -n -e '2 p' "$BASE16_CONFIG")
  if [ "$BACKGROUND" = 'dark' ]; then
    dark "$SCHEME"
  elif [ "$BACKGROUND" = 'light' ]; then
    light "$SCHEME"
  else
    echo "error: unknown background type in $BASE16_CONFIG"
  fi
else
  # default
  dark ocean
fi

function tmux() {
  emulate -L zsh

  # Make sure even pre-existing tmux sessions use the latest SSH_AUTH_SOCK.
  # (Inspired by: https://gist.github.com/lann/6771001)
  local SOCK_SYMLINK=~/.ssh/ssh_auth_sock
  if [ -r "$SSH_AUTH_SOCK" -a ! -L "$SSH_AUTH_SOCK" ]; then
    ln -sf "$SSH_AUTH_SOCK" $SOCK_SYMLINK
  fi

  # If provided with args, pass them through.
  if [[ -n "$@" ]]; then
    env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux "$@"
    return
  fi

  # Check for .tmux file (poor man's Tmuxinator).
  if [ -x .tmux ]; then
    # Prompt the first time we see a given .tmux file before running it.
    local DIGEST="$(openssl sha -sha512 .tmux)"
    if ! grep -q "$DIGEST" ~/..tmux.digests 2> /dev/null; then
      cat .tmux
      read -k 1 -r \
        'REPLY?Trust (and run) this .tmux file? (t = trust, otherwise = skip) '
      echo
      if [[ $REPLY =~ ^[Tt]$ ]]; then
        echo "$DIGEST" >> ~/..tmux.digests
        ./.tmux
        return
      fi
    else
      ./.tmux
      return
    fi
  fi

  # Attach to existing session, or create one, based on current directory.
  SESSION_NAME=$(basename "$(pwd)")
  env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux new -A -s "$SESSION_NAME"
}

alias t=tmux
alias v=nvim

