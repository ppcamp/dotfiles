# .zshrc config

```sh
# Load Zinit for plugin management and configuration
source $HOME/.config/shell/init.zsh

############################# SSH Agent plugin config
zstyle :zen:plugins:ssh-agent agent-forwarding yes
zstyle :zen:plugins:ssh-agent lifetime 2h
zstyle :zen:plugins:ssh-agent identities $HOME/.ssh/file
zstyle :zen:plugins:ssh-agent quiet yes
zinit ice wait"0a" lucid
zinit light $ZEN/pkg/ssh-agent

############################# Go programs
# asdf where golang | xargs -I{} realpath {}/bin
# asdf where golang | xargs -I{} realpath {}/packages/bin
# go env GOPATH | xargs -I{} realpath {}/bin
# go env GOBIN | xargs -I{} realpath {}/bin
export PATH="$PATH:$HOME/.asdf/installs/golang/1.24.3/packages/bin"
export PATH="$PATH:$HOME/.asdf/installs/golang/1.24.3/bin"

############################# Rust crates
# asdf where rust | xargs -I{} realpath {}/bin
# rustc --print sysroot | xargs -I{} realpath "{}/../../bin" | xcp
CARGO_FOLDER="$HOME/.asdf/installs/rust/1.87.0/bin"
export PATH="$PATH:$CARGO_FOLDER"

```