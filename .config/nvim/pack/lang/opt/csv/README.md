---
title:  "CSV Plug-in: Documentation"
author: "jessekelighine@gmail.com"
date:   "2021-Aug-17"
---

# Introduction

This is a ultra-minimal plug-in for CSV **viewing**, not editing.
Features include:

- Focus/highlight on a column, either (1) in the CSV file or (2) from the index
  file.  If index if open, then highlight the corresponding line in the index
  file.
	1. `HighlightColumn`: focus/highlight on the column.
		- `GetColumnNumber`: get the column number.
		- `GetColumnName`: get the column name.
		- `SetColumn`: set column number and column name.
		- `IsVisible`: check if index file is open.
		- `HighlightIndex`: highlight the corresponding line given column
		  number.
	2. `FromIndex`: if highlighting from index file, then returns to
	   `HighlightColumn` with column number and name given, no need to 'get'
	   again.
- Column navigation: (1) go to the focused column; (2) display information; (3)
  go to next/prev column; (4) select the current column under cursor.
	3. `GoToColumn`: go to the focused column.
	4. `ColumnInfo`: display information: column number, name, deliminator,
	   search string type.
	5. `SelectCurrentEntry`: visual select the entry under cursor.
	6. `PrevNextColumn`: move to next/previous column.
- Make/open an index file for easy navigation; can be saved.
	7. `OpenIndex`: make or open (old/new) index file.
	8. `ToggleKeepIndexFile`: change the index file's name to keep/remove it
	   after quitting vim.
- conversion between CSV and TSV; converts hard to handle character to HTML
  entities.
	9. conversion between CSV and TSV.
		1. `ToTsv`: if `b:danger` is set, then the conversion will call the
		   following functions:
			- `MakeSimple`: convert hard to handle characters to HTML entities.
			- `ExpandEntities`: convert HTML entities to plain text.
		2. `ToCsv`
- hide the deliminator for easy viewing.
	10. `ConcealVisibleDelim`: conceal the deliminator.
- search in the focused column and count matches
	11. `SearchInColumn`: search in the focused column.
	12. `NumberOfMatches`: show number of matches in the focused column;
	   can also be used for searches in all columns.
- count number of columns
	13. `NumberOfColumns`: returns the number of columns.
- Basic settings and utilities:
	* `SetCsvDelim`: set the deliminator.
	* `BuildSearchString`: build search string for CSV column.
	* `DangerouOrSimple`: determines whether the CSV file is safe to use
	   simple search strings or contains potential danger.
	* `ToggleSuperSimple`: manually set whether simple search string is used.
	* `StripSearch`: strip the search result to obtain the first argument
	   (number of matches).
