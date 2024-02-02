---
title:  "vim-Hilite"
author: "jessekelighine@gmail.com"
date:   "2022-Apr-18"
---

# vim-Hilite

This is a simple plugin that highlights specific regions that can be defined by
line and column positions (region selected in visual mode).

## Usage

Select the area you want to highlight in *Visual Mode* and press the trigger
key. If you want to clear the highlights, press the trigger in *Normal Mode*.

The default trigger is `<Space>`.  You can change the trigger by setting 
`g:hilite_trigger`. For example, if you want `<Tab>` to be the trigger, put
```vim
let g:hilite_trigger = '<Tab>'
```
in your `.vimrc`.

## Caveats

This plugin does not work well with virtual characters (especially in *Visual
Block Mode*), such as `<Tab>` or CJK characters.
