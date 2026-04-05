---
title:  "Neovim Config"
author: "jessekelighine.com"
date:   2026-04-05
---

# Copy to System Clipboard on MacOS

The following can copy to the system clipboard on a Mac. However, if feature
`clipboard` is included in the vim you are using, then one can simply yank to
register `*`, which is represents the system clipboard register.

```vim
xnoremap <silent> '' :<CR>:let @a=@" \| execute "normal! vgvy" \| let res=system("pbcopy", @") \| let @"=@a<CR>
```

# Spell

Use `:mkspell! %` in each `.add` file in directory `spell` after a fresh install.
This will generate the vim-binaries according to `.add` that `:spell` will respect.
