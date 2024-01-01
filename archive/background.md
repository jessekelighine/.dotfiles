---
title: "Run Jobs in the Background"
date:  "2023-12-05"
---

1. Run some command.
2. Press `<C-Z>` to suspend the job.
3. Run `bg` to make it run the background.
4. Run `disown` to remove the job from the job list.
5. Use `ps x` to check that the job is running.

```sh
<COMMAND> & disown
```
