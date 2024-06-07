# Title Case

Convert a sentence into title case.
Simply select a sentence in visual mode and type `:TitleCase`.

## Settings

- `g:titlecase_alphabet` (regex pattern):
  A set of characters that are recognised as alphabet that can be capitalized.
  The default contains common (extended) Latin alphabets used in French and German.
- `g:titlecase_respect_caps` (boolean):
  Whether to respect the capitalization of the original sentence.
  If set to `0`/`1`, then the sentence would/*wouldn't* be converted to all lower case before converting to title case.
- `g:titlecase_respect_caps_in_ignore_words` (boolean):
  Whether to respect the capitalization of words in the ignore list `g:titlecase_ignore_words`.
  This setting is only effective when `g:titlecase_respect_caps` is set to `1`.
- `g:titlecase_ignore_words` (list of strings):
  A list of words that should *not* be capitalized in title case.
  The default list contains common English articles, prepositions, etc.

## Licence

Distributed under the same terms as Vim itself. See `:help license`.
