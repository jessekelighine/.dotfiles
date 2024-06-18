---
title: "data.table: dcast"
date:  "2023-12-03"
---

*data.frame.long*

| month | day | variable | value |
|-------|-----|----------|-------|
| 5     | 1   | ozone    | 41    |
| 5     | 2   | ozone    | 36    |
| 5     | 3   | ozone    | 12    |
| 5     | 1   | wind     | 7.4   |
| 5     | 2   | wind     | 8.0   |
| 5     | 3   | wind     | 12.6  |
| 5     | 1   | temp     | 18    |
| 5     | 2   | temp     | 20    |
| 5     | 3   | temp     | 24    |

# dcast 1

```r
dcast(data      = data.frame.long,
      formula   = math + day ~ variable,
      value.var = "value")
```

| month | day | ozone | temp | wind |
|-------|-----|-------|------|------|
| 5     | 1   | 41    | 18   | 7.4  |
| 5     | 2   | 36    | 20   | 8.0  |
| 5     | 3   | 12    | 24   | 12.6 |
