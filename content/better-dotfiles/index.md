+++
title = "Better Dotfiles"
date = 2024-09-10

[extra]
hn = 41453264
+++

{{ video(
  src="demo.mp4",
  caption="Demo of my dotfile workflow"
) }}

Whilst reorganising my dotfiles I avoided superfluous dotfile managers and
the limitations of the "version control $HOME" method by instead including
first-line comments of the form `<comment delimiter> ln <link name>` in files
which needed to be symlinked.

Examples:
```
~: head -n 1 ~/dotfiles/helix/config.toml
# ln ~/.config/helix/config.toml

~: head -n 1 ~/dotfiles/polybar/config.ini
; ln ~/.config/polybar/config.ini

~: head -n 1 ~/dotfiles/x/keyboard.conf
# ln /etc/X11/xorg.conf.d/00-keyboard.conf
```

The files can be scanned and symlinks can be created with some awk magic:

```bash
find ~/dotfiles -type f \
  | xargs -I {} awk 'NR == 1 && $2 == "ln" {
    system("ln -sf " FILENAME $3)
  }' {}
```

If we change our awk to just print, add a substitution for `~`, ignore the
`.git` directory when searching for files and package everything up in a
function we end up with:

```bash
list_symlinks () {
  find $(dirname $0) \
    -type f ! -path '*.git/*' \
    | xargs -I {} awk 'NR == 1 && $2 == "ln" { print FILENAME " " $3 }' {} \
    | sed "s|^./|$(pwd)/|;s|~|$HOME|"
}
```

`list_symlinks` can then be piped into awk to create utility commands for
managing symlinks:

```bash
# create symlinks
list_symlinks | awk '{system("ln -sf " $1 " " $2)}'

# remove all symlinks
list_symlinks | awk '{system("rm " $2)}'

# list symlinks
list_symlinks | awk '{ print $2 " -> " $1 }' | column -t
```

Using `readlink` we can enhance our symlink list to show broken symlinks:

```bash
echo -e "$( \
  [[ $(readlink $2) = $1 ]] \
    && echo "\033[32m✓" \
    || echo "\033[31m✗" \
  ) $2 -> $1 \033[0m"
```

Example output:

<!--
```
✓ ~/.i3/config -&gt; ~/dotfiles/i3/config       [!green]
✓ ~/.zshrc     -&gt; ~/dotfiles/zsh/.zshrc      [!green]
✗ ~/.xinitrc   -&gt; ~/dotfiles/x/.xinitrc      [!red]
✗ ~/.gitconfig -&gt; ~/dotfiles/git/.gitconfig  [!red]
```
-->

<!-- move to shortcode -->
<pre style="white-space: normal; background: #fcf0ca">
  <code style="white-space: normal;">
    <div style="color: #090;">✓ ~/.i3/config -&gt; ~/dotfiles/i3/config</div>
    <div style="color: #090;">✓ ~/.zshrc     -&gt; ~/dotfiles/zsh/.zshrc</div>
    <div style="color: #f22;">✗ ~/.xinitrc   -&gt; ~/dotfiles/x/.xinitrc</div>
    <div style="color: #f22;">✗ ~/.gitconfig -&gt; ~/dotfiles/git/.gitconfig</div>
  </code>
</pre>

We can also use the power of awk to remove old links when we update our files
(this sits nicely in a git post-commit hook).

```bash
git diff HEAD~ | awk '/\-\S*\s+ln/ {
  if(prevLine ~ /@@ -1/) {
    system("rm " $3)
  }
} { prevLine=$0 }'
```

See [my dotfiles](https://github.com/dansalias/dotfiles) for a full script which
includes escalating with `sudo` when required.

What I like about this method is that:
- it still allows a self-contained dotfile directory (mine is `~/dotfiles`).
- a separate record of symlinks isn't required because symlinks are specified in
the linked files themselves.
- checking links is trivial.
- the only dependencies are commands common to most *nix distributions.

Try it and see what you think.
