## Git configs

> Note that when using zsh + git plugin, it'll create aliases for
> some of the git commands

<details>
	<summary>
		<code>~/.gitconfig</code>
	</summary>
	
```bash
[credential]
    helper = store
[init]
    defaultBranch = main
[user]
    name = Pedro Santos
    email = pedro.santos@emailprovider.com
[core]
    editor = code --wait
    pager = less -IR -
[diff]
    tool = vscode
[difftool "vscode"]
    cmd = code --wait --diff $LOCAL $REMOTE
[merge]
    tool = vscode
[mergetool "vscode"]
    cmd = code --wait $MERGED
[alias]
    graph = log --graph --oneline --decorate
    graph-main = !git graph $(git curr) main
    curr = rev-parse --abbrev-ref HEAD
    ls = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate
    ll = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat
    lds = log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short
    conflicts = diff --name-only --diff-filter=U
    authors = !git log --format='%aN <%aE>' | grep -v 'users.noreply.github.com' | sort -u --ignore-case
    recent-branches = !git branch --sort=-committerdate | head
    local-branches = !git branch -v | cut -c 3- | awk '{ print $2\" \"$1 }'
    s = !git status
    f = !git fetch
    p = !git pull
    c = !git branch | fzf | xargs git checkout
    sync = !git f && git p
```
</details>
	
<details>
	<summary>
		<code>~/.gitconfig-personal</code>
	</summary>

```bash
[user]
    name = USER
    email = USER's email
[init]
    defaultBranch = main
```

</details>

<details>
	<summary>
		<code>~/.gitconfig-work</code>
	</summary>

```bash
[url "https://bitbucket.ORGANIZATION.com/scm/PROJECT/REPO"]
    insteadOf = https://ORGANIZATION.com/REPO
[init]
    defaultBranch = main
[user]
    name = SOME USER NAME
    email = YOUR EMAIL
```

</details>