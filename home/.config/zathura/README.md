---
title:  "Zathura Installation"
author: "jessekelighine.com"
date:   "2021-08-02"
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
