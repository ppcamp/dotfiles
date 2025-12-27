# vim: ts=2 sts=2 sw=2 et:

# Aliases can also be defined in PET, to find it easier
# use unset to unload some alias

### nvim
alias n='nvim'

### bat/batcat
# alias bat='batcat'

### sudo with user's path
# Note that when running sinde "sudo su" it won't work
alias sudo='sudo env PATH=$PATH'

### size in human readable format
alias duh='du -sh'

### permissions
#alias perm='stat --format="%a %n"'

### Dir stack (see pushd and popd)
alias dirs='dirs -v'

### cd
alias -g '...'='../..'
alias -g '....'='../../..'
alias -- -='cd -'
#alias 1='cd -1'

### listing
alias ls='ls --color=always --human-readable --group-directories-first'
alias l='eza -l --git-ignore'
alias l1='eza -1'
alias lsf='eza -f'
alias lsd='eza -D'
alias la='eza -A'
alias ll='eza -l --icons'
alias llo='ll -o'
alias lls='ll --sort=size'
alias llr='ll --sort=size --reverse'
alias tree='eza --tree'

### python3 (w/ python2 installed)
alias python='python3'
alias pip='pip3'
alias py='python'

### Jobs bash
alias backgroundJob='bg'         # Ctrl+Z
alias foregroundJob='fg'         # Ctrl+Z .. fg %JOB_NUMBER
alias jobsInBackground='jobs -l' # see jobs
alias jl='jobs -l'

### list my aliases
alias myaliases='rg -e "^alias " .bash_aliases .bashrc .zshrc'

### static server
alias sserve='python3 -m http.server'

### wsl network conn
alias checkconn='ping 8.8.8.8'

### Copy alternatives
# WARN: prefer to use a shell script for this, otherwise, programs such FZF
# won't be able to call this.
#alias xcp='xclip -selection clipboard' # for linux (install by apt)
#alias xcp='clipcopy' # for linux (install by apt) -- clipcopy can be defined as
#alias xpb='clippaste'

### others
alias cls='clear'
alias h='history'
alias hist='history'
alias historyclear='history -a -p'
alias table='column -t'
alias now='date +"%Y-%m-%dT%H:%M:%SZ"'

### open files
# see https://pt.linux-console.net/?p=19677
alias -s {py,go,mod,html,js,ts,zsh,md,sql,md,txt,json}=nvim

### Alias for kitty terminal (see images on terminal)
alias icat='kitten icat'

### Github
alias gist='gh gist'
alias copilot='gh copilot'

### Podman
alias pd='podman'

### difft
alias dift='difft'

### Source
alias sc='source'

### BSD tar (tar with zip support)
alias btar='bsdtar'

### (I)nspect reads command output in a nvim buffer, e.g, `apt search bsdtar I`
# alias -g I='2>&1 | nvim -R'

### Custom
# alias test_omzsh='time ZDOTDIR=$HOME/omzsh/ zsh -i -c exit'
# alias test_sh='time ZDOTDIR=$HOME zsh -i -c exit'

### Lazygit
alias lazy='LANG=en_US.UTF-8 lazygit'

## Chezmoi
alias cz='chezmoi'

### Lefthook
alias lh='lefthook'

### ZSH print (with support to %F{red} and %B)
alias print='print -P'

### Gofolder
alias gofolder='cd $(go env GOROOT)'

### Qalculator (with newer QT UI, only works for flathub)
alias qalc='flatpak run --command=qalc io.github.Qalculate.qalculate-qt'

### Toolbox with bash (avoid issues with zsh plugins)
# alias tbx='SHELL=/usr/bin/bash toolbox enter tbx'

### diff
alias diff='diff -w --color'

### strings
alias join='tr -d "\n"'
alias unident='tr -d "\t"'
alias wrapchars='head -c'
alias enumerate='nl'

### jq (json procesor)
alias jq='yq -Poj'

#### ai
alias ai='gemini'

### functions
alias allfunctions='functions | rg -oN -r "$1" "^([a-zA-Z0-9]+)\s*\("'

### gum (better tui)
alias gumf='gum filter --no-limit'

### docker-related
alias docker-ps="docker ps --format '{{.ID}}\t{{.Names}}'"
alias docker-stop="docker ps -f 'status=running' --format '{{.ID}}\t{{.Names}}' | gumf --header='Docker Stop' | cut -f1 | xargs docker stop"
alias docker-start="docker ps -f 'status=exited' --format '{{.ID}}\t{{.Names}}' | gumf --header='Docker Start' | cut -f1 | xargs docker start"
#alias compose-ps="docker compose ls --all"
#alias compose-stop="compose-ps | gumf --header='Docker Compose Stop' | cut -f1 | xargs docker stop"
#alias compose-start="compose-ps | gumf --header='Docker Compose Start' | cut -f1 | xargs docker start"
