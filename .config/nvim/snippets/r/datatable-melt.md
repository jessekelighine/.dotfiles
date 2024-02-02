---
title: "data.table: melt"
date:  "2023-12-03"
---

*data.frame.wide*

| student | school | english | math  | physics |
|---------|--------|---------|-------|---------|
| Andy    | Z      | 10      | 20    | 30      |
| Bernie  | Y      | 100     | 200   | 300     |
| Cindey  | Z      | 1000    | 2000  | 3000    |
| Deb     | Y      | 10000   | 20000 | 30000   |

# melt 1

```r
melt(data          = data.frame.wide,
     id.vars       = c("student", "school"),
     variable.name = "class",
     value.name    = "grade")
```

| student | school | class   | grade |
|---------|--------|---------|-------|
| Andy    | Z      | english | 10    |
| Bernie  | Y      | english | 100   |
| Cindey  | Z      | english | 1000  |
| Deb     | Y      | english | 10000 |
| Andy    | Z      | math    | 20    |
| Bernie  | Y      | math    | 200   |
| Cindey  | Z      | math    | 2000  |
| Deb     | Y      | math    | 20000 |
| Andy    | Z      | physics | 30    |
| Bernie  | Y      | physics | 300   |
| Cindey  | Z      | physics | 3000  |
| Deb     | Y      | physics | 30000 |

# melt 2

```r
melt(data          = data.frame.wide,
     id.vars       = "student",
	 measure.vars  = c("english", "math"),
     variable.name = "class",
     value.name    = "grade")
```

| student | class   | grade |
|---------|---------|-------|
| Andy    | english | 10    |
| Bernie  | english | 100   |
| Cindey  | english | 1000  |
| Deb     | english | 10000 |
| Andy    | math    | 20    |
| Bernie  | math    | 200   |
| Cindey  | math    | 2000  |
| Deb     | math    | 20000 |
| Andy    | physics | 30    |
| Bernie  | physics | 300   |
| Cindey  | physics | 3000  |
| Deb     | physics | 30000 |

# melt 3

```r
melt(data          = data.frame.wide,
     id.vars       = "student",
     variable.name = "class",
     value.name    = "grade")
```

| student | class   | grade |
|---------|---------|-------|
| Andy    | school  | Z     |
| Bernie  | school  | Y     |
| Cindey  | school  | Z     |
| Deb     | school  | Y     |
| Andy    | english | 10    |
| Bernie  | english | 100   |
| Cindey  | english | 1000  |
| Deb     | english | 10000 |
| Andy    | math    | 20    |
| Bernie  | math    | 200   |
| Cindey  | math    | 2000  |
| Deb     | math    | 20000 |
| Andy    | physics | 30    |
| Bernie  | physics | 300   |
| Cindey  | physics | 3000  |
| Deb     | physics | 30000 |
