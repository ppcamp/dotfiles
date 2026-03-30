# vim: ts=2 sts=2 sw=2 et

# load a file called aliases in this dir
#source ${0:A:h}/aliases.zsh

# Colouring MAN pages using Man
GROFF_NO_SGR=1                # Enable old escape sequences -- without this, wont colour
LESS_TERMCAP_mb=$'\E[1;31m'   # Start blink (Red)
LESS_TERMCAP_md=$'\E[1;36m'   # Start bold (Cyan)
LESS_TERMCAP_me=$'\E[0m'      # End all modes
LESS_TERMCAP_se=$'\E[0m'      # End standout
LESS_TERMCAP_so=$'\E[01;33m'  # Start standout (Yellow)
LESS_TERMCAP_ue=$'\E[0m'      # End underline
LESS_TERMCAP_us=$'\E[1;4;32m' # Start underline (Green)

# Colouring Man pages with newer less version (more colours)
GROFF_NO_SGR=1 # Enable old escape sequences -- without this, wont colour
alias pman='MANPAGER="less -R --use-color -Dd+r -Du+g" man'
