;; extends

(generic_command command: (command_name) @function.macro arg: (curly_group (_) @nospell @markup.underline) (#eq? @function.macro "\\gls\*"))
(generic_command command: (command_name) @function.macro arg: (curly_group (_) @nospell @markup.underline) (#eq? @function.macro "\\nameref"))

;((generic_command command: (command_name) @markup.strong) (#match? @markup.strong "\\verb"))
;((generic_command command: (command_name) @markup.strong) (#match? @markup.strong "\\verb"))
