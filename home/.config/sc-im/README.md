---
title:  "SC-IM cheat sheet"
author: "https://cheatography.com/isaacnewton/cheat-sheets/sc-im/"
date:   "2021-Jul-02"
---

# misc

- How to search: have to put search string (regex) between double quotes.
- How to copy to system clip board: have to put `set DEFAULT_COPY_TO_CLIPBOARD_CMD="pbcopy <"`
  to the config file.

# Basic Navigation

- `hjkl`  Move cursor down, up, right or left.
- `^`     Go up to row 0 of the current column.
- `#`     Go down to the last valid row of the current column.
- `0`     Go left to column A in the current row.
- `$`     Go right to the last valid column of the current row.
- `b/w`   Go back/forward to the previous valid cell.
- `gg/G`  Go to the first/last cell of sheet.
- `gl`    Go to the last (previously occupied) cell position
- `gab24` Go to cell `AB24`.
- `'{aZ}` Go to the cell/range marked previously with the char.

# Insert Mode

- `=`     Enter a numeric constant or expression.
- `<`     Enter a left justified string or string expression.
- `\`     Enter a centered label.
- `>`     Enter a right justified string or string expression.
- `<bs>`  Delete the character after or before the cursor.
- `<tab>` Return to Edit mode from Insert mode.
- `^v`    Enter Visual mode.

# Commands for handling cell content

- `x`       Delete the current selected cell or range and save its content in the yank-buffer.
- `{}|`     Align the content of a cell to the left/right/center.
- `f[jk]`   Decrement­/Increment decimal precision.
- `f[hl]`   Decrement­/Increment column width.
- `i[rc]`   Insert a row/column.
- `o[rc]`   Insert after the current row/column.
- `s[hjkl]` Shifts the current cell or range left/down­/up­/right.
- `yy`      Yank the selected cell.
- `y`       If a range is selected, yank the range.
- `y[rc]`   Yank current row/column.
- `p`       Paste the previously yanked cell or range.
- `d[rc]`   Delete the current row/column.
- `-/+`     Decrease/Increase a numeric value of the cell or range.
- `u/^r`    UNDO/REDO last change
- `.`       Repeat the last normal mode command.
- `aa`      Auto-resize the selected column(s) to accommodate the widest cells

# Scroll Navigation

- `^[fb]` Scrolls down/up full screen.
- `^[ey]` Scroll a row down/up.
- `z[hl]` Scroll left/right one column.
- `z[HL]` Scroll left/right half a page.
- `zm`    Horizontally to position the selected cell at the center of the screen.
- `zz`    Vertically to position the selected cell at the middle of the screen.
- `z[tb]` Vertically to position the selected cell at the top/bottom of the screen.

# Visible Navigation

- `H`  Go to the top row visible on screen.
- `L`  Go to the lowest row visible on screen.
- `M`  Go to the middle row on the screen.
- `g0` Go to the leftmost column visible on screen.
- `g$` Go to the rightmost column visible on screen.
- `gM` Go to the middle column on the screen.

# Other commands

- `^L`    Redraw the screen.
- `Z[rc]` Zap (hide) the current row/column.
- `S[rc]` If a range is selected, show the rows/columns hidden in the range.
- `/`     Alias for ':int goto '.
- `n/N`   Move to next/previous search match.
- `rl`    Lock the current cell or range.
- `ru`    Unlock a locked cell or range, making it editable.
- `rv`    Valueize the current cell or range.
