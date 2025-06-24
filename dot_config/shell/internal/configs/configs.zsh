# vim: ts=2 sts=2 sw=2 et:
#                               Set up the prompt

bindkey -v # Use vi key bindings

# disable terminal control flow (Ctrl+Q and Ctrl+S)
# This is a very very old way to block terminal consuming keys for serial
# connections. And when we don't disable this, the terminal may not activate
# bindkeys that use this keybindings properly.
stty -ixon

### History Settings
setopt SHARE_HISTORY               # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST      # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_ALL_DUPS        # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE           # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS           # Do not write a duplicate event to the history file.
setopt HIST_VERIFY                 # Do not execute immediately upon history expansion.
setopt INC_APPEND_HISTORY          # Write to the history file immediately, not when the shell exits.
#setopt EXTENDED_HISTORY           # Write the history file in the ':start:elapsed;command' format.
#setopt APPEND_HISTORY             # append to history file
#setopt HIST_NO_STORE              # Don't store history commands
#setopt HIST_IGNORE_DUPS           # Do not record an event that was just recorded again.
#setopt HIST_FIND_NO_DUPS          # Do not display a previously found event.
#setopt histignorealldups sharehistory

### cd/dirs stack settings
setopt AUTO_CD             # cd to a directory if the name is given
setopt AUTO_PUSHD          # automatically push dirs to stack on cd
setopt PUSHD_IGNORE_DUPS   # don't push duplicates to stack
setopt PUSHD_MINUS         # popd with - goes to last dir
setopt PUSHD_SILENT        # don't show pushd output
setopt PUSHD_TO_HOME       # pushd with no args goes to $HOME

# OTHERS settings
setopt EXTENDED_GLOB       # used to allow ^ negative glob
setopt interactivecomments # allow comments in shell
setopt BANG_HIST           # allow to use "!!" to get the last command.
#setopt CORRECT_ALL        # correct all commands
#setopt CORRECT            # correct commands only

# thanks to https://thevaluable.dev/zsh-completion-guide-examples/
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.cache/zsh"
# zstyle ':completion:*' menu select # Enable menu selection
# zstyle ':completion:*' menu select=long
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling completions: %p%s'
eval "$(dircolors -b)" # color suggestions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:*:make:*' tag-order 'targets'


zstyle ':completion:*' rehash true # Rehash completions when a command is run
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*' # Enable case-insensitive matching
zstyle ':completion:*' verbose true # Show descriptions next to options
zstyle ':completion:*' group-name '' # Group similar results together

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
