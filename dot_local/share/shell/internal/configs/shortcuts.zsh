# vim: ts=2 sts=2 sw=2 et:

# Ctrl+A
# Ctrl+E
# Ctrl+W
# Ctrl+Backspace to kill word

# zle -L # to list all registered zsh widgets
# bindkey -M vicmd v edit-command-line

# Zsh-autossugestions
bindkey '^y' autosuggest-accept # accept word suggestion
bindkey '^ ' forward-word       # accept suggestion
# Move forward/backward by a word
bindkey '^[[1;5C' forward-word  # Ctrl + Right
bindkey '^[[1;5D' backward-word # Ctrl + Left

bindkey '^H' backward-kill-word # ctrl+backspace to kill word
bindkey '^[[3;5~' kill-word     # ctrl+delete to kill word

copy-lbuffer() {
  echo -n "$LBUFFER" | xcp && LBUFFER=''
}
zle -N copy-lbuffer copy-lbuffer # register widget to copy
bindkey '^[w' copy-lbuffer       # alt+w copy

bindkey '^I' menu-complete           # TAB/Ctrl+i cycles forward
bindkey '^[[Z' reverse-menu-complete # Shift+TAB cycles backward

# bindkey # Shows the key bindings
# Ctrl+x ctrl+v # opens the vi mode

# Edit command line in a new $EDITOR when hitting ctrl+x ctrl+e
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
