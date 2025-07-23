---
title: "Notes on `fd`"
author: "https://jessekelighine.com"
date: "2025-07-22"
---

# About `.fdignore`

To ignore files/directories, put

```ignore
directory_to_ignore
file_to_ignore
```

in `.fdignore` in the root of the project.
To *unignore* files/directories, put

```ignore
!directory_to_unignore
!file_to_unignore
```

in `.fdignore` in the root of the project.
