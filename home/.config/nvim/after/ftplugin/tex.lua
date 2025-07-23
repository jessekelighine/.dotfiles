-- ~/.config/nvim/after/ftplugin/tex.lua
-- ~/.config/nvim/after/ftplugin/tex.vim

--- FONT STYLES ---------------------------------------------------------------

vim.keymap.set("i", "\\em<Tab>", function() vim.snippet.expand("\\emph{$1} $0") end, { buffer = true })
vim.keymap.set("i", "\\it<Tab>", function() vim.snippet.expand("\\textit{$1} $0") end, { buffer = true })
vim.keymap.set("i", "\\bf<Tab>", function() vim.snippet.expand("\\textbf{$1} $0") end, { buffer = true })
vim.keymap.set("i", "\\sc<Tab>", function() vim.snippet.expand("\\textsc{$1} $0") end, { buffer = true })
vim.keymap.set("i", "\\tt<Tab>", function() vim.snippet.expand("\\texttt{$1} $0") end, { buffer = true })
vim.keymap.set("i", "\\sf<Tab>", function() vim.snippet.expand("\\textsf{$1} $0") end, { buffer = true })
vim.keymap.set("i", "\\ud<Tab>", function() vim.snippet.expand("\\underdot{$1} $0") end, { buffer = true })
vim.keymap.set("i", "\\v<Tab>", function() vim.snippet.expand('\\verb"$1" $0') end, { buffer = true })
vim.keymap.set("i", "\\V<Tab>", function() vim.snippet.expand('\\Verb"$1" $0') end, { buffer = true })

--- MATH FONT STYLES ----------------------------------------------------------

vim.keymap.set("i", "\\t<Tab>", function() vim.snippet.expand("\\text{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\mb<Tab>", function() vim.snippet.expand("\\mathbf{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\mf<Tab>", function() vim.snippet.expand("\\mathsf{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\mt<Tab>", function() vim.snippet.expand("\\mathtt{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\mr<Tab>", function() vim.snippet.expand("\\mathrm{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\bb<Tab>", function() vim.snippet.expand("\\mathbb{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\mc<Tab>", function() vim.snippet.expand("\\mathcal{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\ms<Tab>", function() vim.snippet.expand("\\mathscr{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\mk<Tab>", function() vim.snippet.expand("\\mathfrak{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\bs<Tab>", function() vim.snippet.expand("\\boldsymbol{$1}$0") end, { buffer  = true })

--- MATH STUFF ----------------------------------------------------------------

vim.keymap.set("i", "_<Tab>", function() vim.snippet.expand("_{$1}$0") end, { buffer = true })
vim.keymap.set("i", "^<Tab>", function() vim.snippet.expand("^{$1}$0") end, { buffer = true })
vim.keymap.set("i", "$<Tab>", function() vim.snippet.expand("\\$$0\\$") end, { buffer = true })
vim.keymap.set("i", "\\f<Tab>", function() vim.snippet.expand("\\frac{$1}{$2}$0") end, { buffer  = true })
vim.keymap.set("i", "\\sum<Tab>", function() vim.snippet.expand("\\sum_{${1:i=1}}^{${2:n}} $0") end, { buffer  = true })
vim.keymap.set("i", "\\prod<Tab>", function() vim.snippet.expand("\\prod_{${1:i=1}}^{${2:n}} $0") end, { buffer  = true })

--- QUOTES --------------------------------------------------------------------

vim.keymap.set("i", "`<Tab>", function() vim.snippet.expand("`$1' $0") end, { buffer = true })
vim.keymap.set("i", "``<Tab>", function() vim.snippet.expand("``$1'' $0") end, { buffer = true })

--- ENVIRONMENT ---------------------------------------------------------------

vim.keymap.set("i", "\\b<Tab>", function() vim.snippet.expand("\\begin{$1}\n\t$0\n\\end{$1}") end, { buffer  = true })
