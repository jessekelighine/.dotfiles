---
title:  "VIM - LaTeX"
author: "jessekelighine@gmail.com"
date:   "2022-Jan-04"
---

Since I really do not like the TeXshop layout and Vim is evidently a superior
text editor, I decided on this day, to switch entirely to Vim.  However, there
are many issues to overcome. Such as compiling, short-cuts, etc.  Here is a
list of all the things that must be done for me to use LaTeX in Vim easily.

# Tips

- Install "BasicTeX" ( use `brew install --cask basictex` ).
- Set default papaer size: `sudo tlmgr paper a4`
- Installing new packages: `sudo tlmgr install <pkg-name>`
- Biber fuck-up fix: 
  ```sh
  rm -rf $(biber --cache)
  ```
- Use bopomofo and normal Chinese ellipsis in xeCJK:
  add `"02CA, "02C7 , "02CB , "02D9 , "22EF,` after `"3100,` in the file
  `/usr/local/texlive/2022basic/texmf-dist/tex/xelatex/xecjk/xecjk.sty`
  to create the appropriate mapping.
- Convert pdf output to png: install `imagemagick` through `HomeBrew`.
- See `~/.vim/ftplugin/tex_snippets/PACKAGES.txt` for packages all the packages
  installed using tlmgr. (2021-Dec-25)

# Files (2022-Jan-04)

These are all the files that is created to support `tex` filetype.

- `~/.vim/ftplugin/tex.vim`
- `~/.vim/syntax/tex.vim`
- `~/.vim/pack/lang/opt/tex/ftplugin/`: insert-maps toggled by functions.
- `~/.vim/pack/lang/opt/tex/syntax/`: syntax group toggled by functions.
- `~/.vim/autoload/tex.vim`: all functions used in `tex` filetype.
- `~/.vim/snippets/tex/`: all tex snippets.

# MORE!

- Even faster latex using
  [snippets](https://castel.dev/post/lecture-notes-1/#context)!
- I do not like this extension, since snippets depends on a plugin.
  And I do not need to use snippets, most of the snippets it can be done
  with `surround`.  But maybe in the future I can be bothered to convert
  every thing in `tex.vim` to snippets, though I doubt it would be
  significantly better.
- **Update (2021-May-23)**: I did convert many thing in `tex.vim` into
  snippets!  But I did not use any snippets plugins.  I simply put all all
  snippets (mostly preambles that are impossible to remember) into
  individual files and read from those files into my TeX files.  The
  snippets now lives in `~/.vim/ftplugin/tex_snippets` (called by a simple
  custom function, essentially is just a wrapper for `:r <PATH>` in vim).
  This makes the snippets more manageable and editable.  Furthermore, often
  times I can just simple `\input{PATH}` the snippet files in TeX files,
  making the preamble section much shorter.
