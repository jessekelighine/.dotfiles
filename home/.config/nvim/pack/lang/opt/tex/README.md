---
title:  "VIM - LaTeX"
author: "jessekelighine.com"
date:   "2024-04-25"
---

Since I really do not like the TeXshop layout and Vim is evidently a superior
text editor, I decided on this day, to switch entirely to Vim.  However, there
are many issues to overcome. Such as compiling, short-cuts, etc.  Here is a
list of all the things that must be done for me to use LaTeX in Vim easily.

# SyncTeX with Skim

## Forward

To use forward search (from *tex* to *pdf*),
simply call the function `tex#SkimForward`.

## Backward

### Method 1 (Shell)

To use backward search (from *pdf* to *TeX*),
one need to use the script `synctex-backward.sh`.

Open Skim and set `Preferences/Sync` to:

| Field    | Value                         |
|----------|-------------------------------|
| Preset   | Custom                        |
| Command  | path to `synctex-backward.sh` |
| Argument | `"%line" "%file"`             |

**Note**: Before usage, make sure to use command `:ServerSetup` from the *TeX* file.
This command writes the current server address to a file that is read by `synctex-backward.sh` every time the script is invoked.

Use "`<Cmd>` + `<Shift>` + click" in Skim to backwards search.

### Method 2 (Python)

To use backward search (from *pdf* to *TeX*),
one must first install `neovim-remote` via
```sh
pip install neovim-remote
```

Then, one must designate `NVIM_LISTEN_ADDRESS` in `.zshrc`:
```sh
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
```

Lastly, one must open `Skim` and set `Preferences/Sync` to the following:

| Field    | Value                                          |
|----------|------------------------------------------------|
| Preset   | Custom                                         |
| Command  | `nvr`                                          |
| Argument | `--remote +"%line" "%file"; open -a alacritty` |

The `open` part is to return to the terminal automatically.

- [reference](https://ka.ge/blog/2021/06/23/neovim-synctex-macos.html)

# Tips

- Install `BasicTeX` ( use `brew install --cask basictex` ).
- Set default paper size: `sudo tlmgr paper a4`
- Installing new packages: `sudo tlmgr install <pkg-name>`
- Biber fuck-up fix: 
  ```sh
  rm -rf $(biber --cache)
  ```
- Use bopomofo and normal Chinese ellipsis in xeCJK:
  add `"02CA, "02C7 , "02CB , "02D9 , "22EF,` after `"3100,` in the file
  `/usr/local/texlive/2022basic/texmf-dist/tex/xelatex/xecjk/xeCJK.sty`
  to create the appropriate mapping.
- Convert pdf output to png: install `imagemagick` through `HomeBrew`.
- See `~/.vim/ftplugin/tex_snippets/PACKAGES.txt` for packages all the packages
  installed using `tlmgr`. (2021-12-25)

# Files (2022-01-04)

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
- **Update (2021-05-23)**: I did convert many thing in `tex.vim` into
  snippets!  But I did not use any snippets plugins.  I simply put all all
  snippets (mostly preambles that are impossible to remember) into
  individual files and read from those files into my TeX files.  The
  snippets now lives in `~/.vim/ftplugin/tex_snippets` (called by a simple
  custom function, essentially is just a wrapper for `:r <PATH>` in vim).
  This makes the snippets more manageable and editable.  Furthermore, often
  times I can just simple `\input{PATH}` the snippet files in TeX files,
  making the preamble section much shorter.
