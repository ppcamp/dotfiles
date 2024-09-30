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
[commit]
    template = ~/.git-template
[user]
    name = Pedro Santos
    email = pedro.santos@emailprovider.com
[core]
    editor = code --wait
    pager = less -IR -
[diff]
    tool = vscode
    external = difft
[difftool]
    prompt = false
[difftool "difftastic"]
    cmd = difft "$LOCAL" "$REMOTE"
[difftool "vscode"]
    cmd = code --wait --diff $LOCAL $REMOTE
[merge]
    tool = vscode
[mergetool "vscode"]
    cmd = code --wait $MERGED
[filter "lfs"]
    clean = git-lfs clean -- %f
    smudge = git-lfs smudge -- %f
    process = git-lfs filter-process
    required = true
[alias]
    alias = !sed -n "'/^\\[alias\\]/,/^\\[/{ /^[^[]/ {s/^[ \\t]*//;s/[ \\t]*=[ \\t]*/=/;p } }'" $HOME/.gitconfig | sed -n 's/^\\([a-zA-Z0-9]\\+\\)[[:space:]]*=\\(.*\\)$/\\1?\\2/p' | column -t -s '?'
    ls = log --pretty=format:"%C(yellow)%h\\ %C(green)%ad%C(red)%d\\ %C(reset)%s%C(blue)\\ [%cn]" --decorate --date=short
    graph = log --graph --oneline --decorate
    graph-vs-main = !git graph $(git curr) main
    curr = rev-parse --abbrev-ref HEAD
    conflicts = diff --name-only --diff-filter=U
    authors = !git log --format='%aN <%aE>' | grep -v 'users.noreply.github.com' | sort -u --ignore-case
    recent-branches = !git branch --sort=-committerdate | head
    local-branches = !git branch -v | cut -c 3- | awk '{ print $2\" \"$1 }'
    s = status
    f = fetch --prune
    p = pull
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
	
	
<details>
	<summary>
		<code>~/.git-template</code>
	</summary>

```bash
# <type>[optional scope]: <short_description>
#
# Co-authored-by: Co Author Name <coauthor@email.com>
#
# optional_body may also include references to PR #256,
# to Jira ticket (TICKETid-256). Or a URL
#
# BREAKING CHANGE: <breaking_change_description>
#
################################################################################
# Types:
# - fix           Bugfix
# - feat          New feature/functionality added
# - chore         For files that don't change our source code
# - ci            For changes in pipeline
# - docs          For documentation changes only
# - refactor      Usually, no feature added
# - perf          Performance improvements
# - test          Added/changed tests
#
################################################################################
# For revert commits, use the template below:
# 
# revert: let us never again speak of the noodle incident
#
# Refs: 676104e, a215868
################################################################################
# see https://www.conventionalcommits.org/en/v1.0.0	
```