# shell
Shell config for my personal use

[Suggestted programs](https://gist.github.com/ppcamp/91dd1fc9ae5f3c78026617720e26795e)
[Bash commands](https://gist.github.com/ppcamp/14f3f5cdc71e66d955e21043ec5d27b7)

## Installation

```sh
cd $HOME/.config

# needs to be recursive, so it can fetch the submodules
git clone --recursive https://github.com/ppcamp/shell

mv ~/.zshrc{,.bak}

# while in the folder where you cloned this repo
echo "source $PWD/shell/init.zsh" > ~/.zshrc
```

> WARN: https://github.com/disrupted/dotfiles/blob/master/.zshrc



> [!TIP]
> Run the make commands to install the tools you need.

> [!NOTE]
>
> Must be cloned directly in the folder that you plan to keep it, and then
> replace the `~/.zshrc` for this one.

<details><summary><h2>Zshrc config</h2></summary>

Put this at the end of `$HOME/.zshrc` to load the rest of the config
See `internal/utils/loaders:add_path_if_exec` for more details.

> Check it out the `make configure-paths` command.

```sh
############################## Go
#$ go env GOPATH | xcp
export PATH="$PATH:$HOME/.asdf/installs/golang/1.24.0/packages/bin"
############################## Rust crates
#$ rustc --print sysroot | xargs -I{} realpath "{}/../../bin" | xcp
export CARGO_FOLDER="$HOME/.asdf/installs/rust/1.85.0/bin"
export PATH="$PATH:$CARGO_FOLDER"
############################## node
#$ npm config get prefix | xcp
export PATH="$PATH:$HOME/.asdf/installs/nodejs/lts"
############################## python env
source "$HOME/.cache/venv/bin/activate"
```

Example of `$HOME/.zshrc`:

```sh
# load zen config
source $HOME/.config/shell/init.zsh


############################## Go
#$ go env GOPATH | xcp
export PATH="$PATH:/home/asapcard-note-h1y/go"
############################## Rust crates
#$ rustc --print sysroot | xargs -I{} realpath "{}/../../bin" | xcp
# export CARGO_FOLDER=""
# export PATH="$PATH:$CARGO_FOLDER"
############################## node
#$ npm config get prefix | xcp
export PATH="$PATH:/home/asapcard-note-h1y/.asdf/installs/nodejs/20.18.3"


############################# SSH Agent plugin config
zstyle :omz:plugins:ssh-agent agent-forwarding yes
zstyle :omz:plugins:ssh-agent lifetime 1h
zstyle :omz:plugins:ssh-agent identities ~/.ssh/{bitbucket_,sftp_*}
zstyle :omz:plugins:ssh-agent quiet yes

zinit ice wait"0a" lucid
zinit light $HOME/.config/shell/plugins/ssh-agent
```

</details>

### TODO

- [ ] add the others dotfiles
- [x] add scripts to install tools
- [x] remove submodules, since they are not needed anymore (zinit support)
- [x] improve load performance against omzshc config
- [x] fzf completions not working
- [x] fix paths wrapper import

## Notes

[devhints]

### Performance checking

![image](https://github.com/user-attachments/assets/47572735-5adf-442f-b96f-5363b7f6d51c)


> The omzsh version didn't use the `mcfly` history manager, neither `starship` (it evals everytime starship)

```sh
# time with a custom zsh config
ZDOTDIR=$HOME/omzsh/ zsh -i -c exit
# time
ZDOTDIR=$HOME zsh -i -c exit
```

<!-- # Fetch latest version from GitHub API -->
<!-- # LATEST_VERSION=$(curl -s https://api.github.com/repos/junegunn/fzf/releases/latest | grep tag_name | cut -d '"' -f 4) -->

[devhints]: https://devhints.io/
