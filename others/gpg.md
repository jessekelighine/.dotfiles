---
title: "Migrate GPG Keys from One Workstation to Another"
author: "[angela-d/gpg-key-migration.md](https://gist.github.com/angela-d/8b27670bac26e4bf7c431715fef5cc51)"
date: "2025-05-31"
---

> **Note**:
> Replace **[your key]** with your key ID.
> Reference: [The GNU Privacy Handbook](https://www.gnupg.org/gph/en/manual/book1.html).

To obtain your key ID
```bash
gpg --list-secret-keys --keyid-format LONG
```

Which returns something like
```txt
/home/angela/.gnupg/pubring.kbx
-------------------------------
sec   rsa4096/[your key] 2018-03-30 [SC]
      ABCDEFGHIJKLMNOPQRSTUVWXYZ
uid                 [ unknown] angela (KEY NAME) <user@domain>
ssb   rsa4096/ABCDEFGHIJKL 2018-03-30 [E]

```

After the key size `rsa4096/` is your key ID.

-----

Export the key in preparation to move it
```bash
gpg --export -a [your key] > gpg-pub.asc
```

Prepare the secret key for migration (if password protected, you'll be prompted to enter it)
```bash
gpg --export-secret-keys -a [your key] > gpg-sc.asc
```

Find them
```bash
ls -l gpg*.asc
```

Drag the key pair from the current directory to your USB stick or however else you move them.

Once on the new machine, import them
```bash
gpg --import gpg-pub.asc
```

If password protected, you'll be prompted to enter it
```bash
gpg --import gpg-sc.asc
```

If you need to adjust the trust level
```bash
gpg --edit-key [your key]
```
