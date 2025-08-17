+++
title = "Switching Node Versions Without nvm"
date = 2019-12-09
+++

I have recently been working on two parallel node projects which, for reasons we
won't go into, are exclusively compatible with different versions of node.

I began using [nvm](http://nvm.sh/) to switch node versions. Automatically
switching node versions based on .nvmrc files is great, but I found that nvm
initialisation introduced a **noticeable delay** in starting new terminal
windows. As my workflow is essentially terminals and browsers this was
unacceptable, so I endeavoured to create a simpler solution.

The basic idea is to pre-install required node versions and symlink to the
desired version as needed.

```bash
#!/bin/bash
system=linux-x64
directory=$HOME/.node-versions

# create directory
prepare() {
  mkdir -p $directory
}

# install specified version
install() {
  prepare
  version=$1
  package=node-v$version-$system.tar.xz
  url=https://nodejs.org/download/release/v$version/$package
  wget $url -P $directory
  tar -xf $directory/$package -C $directory
}

# switch active version
switch() {
  version=$1
  ln -sf $directory/node-v$version-$system/bin/node $HOME/.local/bin/node
  ln -sf $directory/node-v$version-$system/bin/npm $HOME/.local/bin/npm
}

case "$1" in
  prepare)
    prepare
    ;;
  install)
    install $2
    ;;
  switch)
    switch $2
    ;;
esac
```

Thankfully the package names back to version 0.10.0 follow the same naming
convention; see [https://nodejs.org/download/release/v12.13.1/](https://nodejs.org/download/release/v12.13.1/).
You'll want to switch to tar.gz URLs if you going back prior to v4 though (the
script currently downloads the tar.xz package).

Also be sure to **change the system variable** at the top of the script to match
your OS.

With the script saved in `$HOME/scripts/node-switch.sh` and an alias:

```bash
alias ns=$HOME/scripts/node-switch.sh
```

We can now do the following:

```bash
ns install 12.13.1
ns switch 12.13.1
```

This is combined with a stripped-down version of the
[.nvmrc switching logic](https://github.com/nvm-sh/nvm/blob/master/README.md#calling-nvm-use-automatically-in-a-directory-with-a-nvmrc-file)
to maintain compatibility with project directories using `.nvmrc`.

```bash
# node-switch alias
alias ns=$HOME/scripts/node-switch.sh

# switch node version based on .nvmrc
default_node_version=12.13.1
chpwd() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    ns switch "$(< .nvmrc)"
  elif [[ $(node --version) != v$default_node_version ]]; then
    ns switch $default_node_version
  fi
}
```

The result is an instantly responsive node version switcher which doesn’t delay
terminal start up. It’s nowhere near as comprehensive as nvm (bash completion,
version look-up, etc) but it’s working well so far.
