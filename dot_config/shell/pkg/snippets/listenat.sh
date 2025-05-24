# Shell listenat function helper. Very usefull to check which process are using some port (POSIX compliant)

############################## function: grep ports
function listenat {
  # ps a --forest | rg -C 5 91578
  # show 5 lines before and after the match

  if [ $# -eq 0 ]; then
    echo "Type listenat --help for tips and usage"
    return 1
  fi

  case $1 in
  --all)
    cat /etc/services | grep tcp
    ;;
  --help)
    echo 'Usage:'
    echo 'listenat [OPTION_OR_PORT]'
    echo 'Example'
    echo 'listenat 8080'
    echo 'listenat --all'
    echo 'listenat --enabled'
    ;;
  --enabled)
    echo "Showing (t)CP (l)istening (p)rocesses without (n)aming port"
    ss -tlpn
    ;;
  *)
    # convert hosts and ports files to the equivalent being accessed
    # grep only the process using that
    # grep only port at $1
    # sudo lsof -nP -t -sTCP:LISTEN -iTCP:$1
    ss -tlpn | rg $1
    ;;
  esac
}
