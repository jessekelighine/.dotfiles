---
title:  "Nvim"
author: "jessekelighine@gmail.com"
date:   "2023-03-29"
---

# Modifications

## franbach/miramare

Here are the needed modifications to `miramare`.

Also, the correct colors (or the colors I like) are defined using 256term,
so make sure in the `miramare/colors/miramare.vim` file,
`s:HL()` function uses 256term defintion.
To do this, set `s:t_Co` to `256`.

```vim
call s:HL('CursorLineNr', s:palette.fg, s:palette.bg3)
call s:HL('Visual', s:palette.none, s:palette.bg1, 'reverse')
call s:HL('NonText', s:palette.bg4, s:palette.none)
call s:HL('SpecialKey', s:palette.bg4, s:palette.none)
call s:HL('MatchParen', s:palette.none, s:palette.bg4, 'bold')
call s:HL('TabLineSel', s:palette.bg0, s:palette.gold)
call s:HL('markdownBold', s:palette.purple, s:palette.none, 'bold')
call s:HL('markdownItalic', s:palette.blue, s:palette.none, 'italic')
call s:HL('CursorColumn', s:palette.none, s:palette.bg3)
call s:HL('CursorLine', s:palette.none, s:palette.bg3)
call s:HL('StatusLine', s:palette.bg1, s:palette.yellow)
call s:HL('StatusLineNC', s:palette.bg1, s:palette.fg)
```

These are the `miramare` colors:

| Name         | RGB       | 256term | term        |
|--------------|-----------|---------|-------------|
| `bg0`        | `#2A2426` | `235`   | `Black`     |
| `bg1`        | `#242021` | `236`   | `DarkGrey`  |
| `bg2`        | `#242021` | `237`   | `DarkGrey`  |
| `bg3`        | `#242021` | `238`   | `DarkGrey`  |
| `bg4`        | `#242021` | `239`   | `Grey`      |
| `bg_red`     | `#392f32` | `52`    | `DarkRed`   |
| `bg_green`   | `#333b2f` | `22`    | `DarkGreen` |
| `bg_blue`    | `#203a41` | `17`    | `DarkBlue`  |
| `fg`         | `#e6d6ac` | `223`   | `White`     |
| `red`        | `#e68183` | `167`   | `Red`       |
| `orange`     | `#e39b7b` | `208`   | `Red`       |
| `yellow`     | `#d9bb80` | `214`   | `Yellow`    |
| `green`      | `#87af87` | `108`   | `Green`     |
| `cyan`       | `#87c095` | `108`   | `Cyan`      |
| `blue`       | `#89beba` | `109`   | `Blue`      |
| `purple`     | `#d3a0bc` | `175`   | `Magenta`   |
| `grey`       | `#444444` | `245`   | `LightGrey` |
| `light_grey` | `#5b5b5b` | `245`   | `LightGrey` |
| `gold`       | `#d8caac` | `214`   | `Yellow`    |

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

# Git settings ( tpope/vim-fugitive )

```vim
nnoremap <leader>ga :Git add<space>
nnoremap <leader>gb :Git branch<space>
nnoremap <leader>gc :Git commit<space>
nnoremap <leader>gd :Git diff<space>
nnoremap <leader>gh :Git stash<space>
nnoremap <leader>gl :Git log<space>
nnoremap <leader>gm :Git merge<space>
nnoremap <leader>gp :Git push -u origin master
nnoremap <leader>gs :Git status<space>
nnoremap <leader>gr :Git reset<space>
nnoremap <leader>gt :Git checkout<space>
```

# Indent Files

- [How to write indent files](https://psy.swansea.ac.uk/staff/carter/vim/vim_indent.htm)

# Hex Editing

```sh
:%!xxd
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
