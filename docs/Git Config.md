## Git configs

> Note that when using zsh + git plugin, it'll create aliases for
> some of the git commands

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


# Tips

<details>
  <summary>Git Aliases</summary>

```sh
# switch to a commit (detached state)
# create a branch from that commit
# then, checkout everything from that commit, to the latest one
git cp ..main
```
</details>

<details>
	<summary>Logging based on the action</summary>

```sh
# git history + changes
git log -p
```

Possible git filters
```
A	Show only added files
C	Show only copied files
D	Show only deleted files
M	Show only modified files
R	Show only renamed files
T	Show only files with type changes (e.g., file → symlink)
U	Show only unmerged (conflicting) files
X	Show unknown files
B	Show only broken pairings (used for detecting broken renames)
```

> Note that you can combine multiple filters

</details>


<details>
	<summary>Generating a Patch file</summary>

```sh
git diff HEAD > ~/changes.patch
git apply ~/changes.patch
```

Note that this **won't work if you changed the external tool for git**, it **must** be the default (diff)

</details>

- https://pre-commit.com/
- https://git-scm.com/book/ms/v2/Customizing-Git-Git-Hooks
- https://git-scm.com/book/en/v2/Git-Tools-Submodules
