# Chezmoi Commands

Applying changes to your system:
```sh
# to update
chezmoi init --apply --data=false
```

Extra commands:
```sh
# to change anything
chezmoi add /usr/bin/fzf-git
chezmoi edit-config
chezmoi data
chezmoi cd
```

Clearing state of `chezmoi` scripts:
```sh
# testing template
chezmoi execute-template < run_once_install-asdf.tmpl | bat

# To clear the state of run_onchange_ scripts, run:
chezmoi state delete-bucket --bucket=entryState

# To clear the state of run_once_ scripts, run:
chezmoi state delete-bucket --bucket=scriptState
```


