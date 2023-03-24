---
title:  "Zathura Installation"
author: "jessekelighine@gmail.com"
date:   "2021-Aug-02"
---

- [mac zathura repo](https://github.com/zegervdv/homebrew-zathura)

```sh
# install zathura
brew tap zegervdv/zathura
brew install zathura

# install pdf plug-in
brew install zathura-pdf-poppler
mkdir -p $(brew --prefix zathura)/lib/zathura
ln -s $(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib $(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib
```
