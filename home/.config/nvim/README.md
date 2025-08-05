---
title:  "Vim Notes"
author: "jessekelighine.com"
date:   "2025-07-30"
---

# Modifications

## junegunn/vim-peekaboo

Make the mappings in `plugin/peekaboo.vim` not `<buffer>` specific, i.e., remove `<buffer>`.

# Bulk (Batch) Rename Files

1. `\ls | vim -`: read all the files into vim
2. `%s/.*/mv -i <PATTERN>/g`: rename files
3. `:%!bash`: write and run the commands

# Old Copy MacOS

The following can copy to the system clipboard on a Mac.
However, if feature `clipboard` is included in the vim you are using,
then one can simply yank to register `*`,
which is represents the system clipboard register.

```vim
xnoremap <silent> '' :<CR>:let @a=@" \| execute "normal! vgvy" \| let res=system("pbcopy", @") \| let @"=@a<CR>
```

# Key Repead Speed on MacOS

```sh
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
```

# Regex Tips

- using the search pattern in `/` in `:%s`.
    - In general, an empty regular expression means to use the previously
      entered regular expression, so `:%s//\1/g` should do what you want.
    - Also, if you want to verify or modify the last used pattern,
      you can use `<C-R>/` to insert the contents of the search pattern register `/`
      directly into a partially typed command line.
- Replacing in visual block:
  use command `:'<,'>s/\%V{pattern}/{replace}/{option}`
  where the `\%V` specifies that the replacement is only done in the selected block.
- Note that atoms in `[]`'s have different meanings.
  E.g., `.` outside of `[]` means any character, but in `[]` it means literally `.`.

# Follow Symlink in Netrw

Netrw for some reason fails to follow symlinks in tree mode.
To follow symlinks, change listing style with `i` and then open symlink.

# Spell

Use `:mkspell! %` in each `.add` file in directory `spell` after a fresh install.
This will generate the vim-binaries according to `.add` that `:spell` will respect.
