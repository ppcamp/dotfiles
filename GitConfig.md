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
    editor = vim #code --wait
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
    alias = config --get-regexp alias
    ls = log --pretty=format:"%C(yellow)%h\\ %C(green)%ad%C(red)%d\\ %C(reset)%s%C(blue)\\ [%cn]" --decorate --date=short # alternative to <git log>, example: <git ls>
    graph = log --graph --oneline --decorate # example: <git graph develop feature/some-14> or just <git graph>
    graph-vs = !git graph $(git curr) # (git graph vs current) example: <git graph-vs SomeBranchName>
    curr = rev-parse --abbrev-ref HEAD # (current branch) example: <git curr>
    conflicts = diff --name-only --diff-filter=U # (show conflicts) example: <git conflicts>
    authors = !git log --format='%aN <%aE>' | grep -v 'users.noreply.github.com' | sort -u --ignore-case # (all authors that commited) example: <git authors>
    recent-branches = !git branch --sort=-committerdate | head # (show recent branches) example: <git recent-branches>
    local-branches = !git branch -v | cut -c 3- | awk '{ print $2\" \"$1 }' # (show local only branches) example: <git local-branches>
    s = status
    f = fetch --prune
    p = pull
    c = !git branch -a | fzf | xargs git checkout # (checkout by showing and selecting) example: <git c>
    sync = !git f && git p # (fetch and pull) example: <git sync>
    pushf = push --force --progress # (force push) example: <git pushf>
    reset-untracked = clean -df # (clean untracked files) example: <git reset-clean>
    reset-hard = reset --hard HEAD # (clean tracked files) example: <git reset-hard>
    reset-all = !git reset-untracked && git reset-hard # (clean all changes) example: <git reset-all>
    delete = !git branch --list | fzf | xargs git branch --delete # example: <git delete>
    new = checkout -B # (create new branches) example: <git new branchName>
    list = branch -v # (list local branches) example: <git list>
    list-remotes = branch --remotes # (list remote branches ref) example: <git list-remotes>
    # git branch -m <branch=new-branch-name>; git push origin <branch>; git push origin --delete <current=$(git curr)>
    rename = branch -m # (rename branch locally, remember to <git push origin branch> + <git delete-remote>) example: <git rename newName>
    delete-remote = git push origin --delete # (delete a given branch in remote) example: <git delete-remote branchName>
    exist-remote = ls-remote --heads origin # (check if exist in remote) example: <git exist-remote branchName>
[commit]
    template = ~/.git-template
[push]
    autoSetupRemote = true
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