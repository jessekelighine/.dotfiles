---
title:  ".dotfiles"
author: "jessekelighine.com"
---

## Install

```sh
git clone --recurse-submodules "https://github.com/jessekelighine/.dotfiles"
cd ~/.dotfiles
make install
```

## Update

```sh
cd ~/.dotfiles
make update
```
## Uninstall

```sh
cd ~/.dotfiles
make uninstall
```

-----

## Dependencies

- `git`
- `stow`: If `stow` is not available, symlinking directly will be performed.
- `make`
