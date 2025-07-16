# trash function (rm safety function)

############################## function: remove safety
# alias rm=trash
# escape alias putting \ before the name
function trash {
  local trashdir
  trashdir="/tmp/trash"

  case $1 in
  "--list")
    print -P "%F{green}Trash%f is defined in %F{cyan}$trashdir%f"
    ls $trashdir
    ;;

  "--clear")
    rm -irfd $trashdir/*
    ;;

  "--help")
    print -P "%F{green}Usage%f\n"
    print -P "%F{green}trash%f files %F{gray}# Move to trash%f"
    print -P "%F{green}trash%f %F{cyan}--list%f %F{gray}# List everything trash'ed%f"
    print -P "%F{green}trash%f %F{cyan}--clear%f %F{gray}# Remove trash'ed files%f"
    print -P "%F{green}trash%f %F{cyan}--help%f %F{gray}# Show this menu%f"
    print -P "%F{green}trash%f %F{cyan}-help%f files %F{gray}# pass everything to rm%f"
    print -P "%F{gray}Trashed itens lives at tmp, therefore, it may get deleted auto%f"
    ;;

  "-"*) # if [[ "$1" == "-"*  ]]; then
    command rm "$@"
    ;;

  *)
    # create everytime if you don't have it
    mkdir -p $HOME/.trash
    mv "$@" $HOME/.trash
    ;;
  esac
}
