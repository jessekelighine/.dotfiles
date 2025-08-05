-- ~/.config/nvim/lua/cmp/tex.lua
-- ~/.config/nvim/after/ftplugin/tex.vim
-- ~/.config/nvim/snippets/tex/

local snippet = require "snippet"
local filetype = "tex"
local language = "latex"
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet:is_available { language = language }

---@param opts table with fields `append`, `content`, and `env`.
---@return string snippet LaTeX environment snippet
local environment = function(opts)
	opts.append = opts.append or ""
	opts.content = opts.content or "\t$0"
	opts.env = opts.env or "$1"
	local env = ""
	env = env .. "\\begin{" .. opts.env .. "}" .. opts.append .. "\n"
	env = env .. opts.content .. "\n"
	env = env .. "\\end{" .. opts.env .. "}"
	return env
end

function source:complete(_, callback)
	local items = {
		-- PREAMBLE:
		snippet.snippet { label = ":skeleton", insertText = snippet:get "tex/skeleton.snippet.tex" },
		{ label = ":letter",       insertText = snippet:get "tex/skeleton-letter.tex" },
		{ label = ":beamer",       insertText = snippet:get "tex/preamble-beamer.tex" },
		{ label = ":standalone",   insertText = snippet:get "tex/preamble-standalone.tex" },
		{ label = ":algorithm",    insertText = snippet:get "tex/preamble-algorithm.tex" },
		{ label = ":cjk",          insertText = snippet:get "tex/preamble-xeCJK.tex" },
		{ label = ":cwtex",        insertText = snippet:get "tex/preamble-cwtex.tex" },
		{ label = ":punct",        insertText = snippet:get "tex/preamble-punct.tex" },
		{ label = ":bib",          insertText = snippet:get "tex/preamble-biblatex.tex" },
		{ label = ":title",        insertText = snippet:get "tex/preamble-title.tex" },
		{ label = ":chenum",       insertText = snippet:get "tex/preamble-chineseenumerate.tex" },
		{ label = ":chnum",        insertText = snippet:get "tex/preamble-chinesenumber.tex" },
		{ label = ":color",        insertText = snippet:get "tex/preamble-color.tex" },
		{ label = ":csv",          insertText = snippet:get "tex/preamble-csv.tex" },
		{ label = ":columns",      insertText = snippet:get "tex/preamble-column.tex" },
		{ label = ":customtitle",  insertText = snippet:get "tex/preamble-customtitle.tex" },
		{ label = ":enumitem",     insertText = snippet:get "tex/preamble-enumerate.tex" },
		{ label = ":fauxsc",       insertText = snippet:get "tex/preamble-fauxsc.tex" },
		{ label = ":figure",       insertText = snippet:get "tex/preamble-graphics.tex" },
		{ label = ":footnote",     insertText = snippet:get "tex/preamble-footnote.tex" },
		{ label = ":font",         insertText = snippet:get "tex/preamble-font.tex" },
		{ label = ":german",       insertText = snippet:get "tex/preamble-german.tex" },
		{ label = ":hyperref",     insertText = snippet:get "tex/preamble-hyperreference.tex" },
		{ label = ":lof",          insertText = snippet:get "tex/preamble-listoffigures.tex" },
		{ label = ":math",         insertText = snippet:get "tex/preamble-math.tex" },
		{ label = ":mathnotes",    insertText = snippet:get "tex/preamble-mathnotes.tex" },
		{ label = ":noorphan",     insertText = snippet:get "tex/preamble-noorphanwidow.tex" },
		{ label = ":problem",      insertText = snippet:get "tex/preamble-problem.tex" },
		{ label = ":probability",  insertText = snippet:get "tex/preamble-mathprob.tex" },
		{ label = ":pagebeamer",   insertText = snippet:get "tex/preamble-pagebeamer.tex" },
		{ label = ":page",         insertText = snippet:get "tex/preamble-fancyhdr.tex" },
		{ label = ":ruby",         insertText = snippet:get "tex/preamble-ruby.tex" },
		{ label = ":table",        insertText = snippet:get "tex/preamble-table.tex" },
		{ label = ":sectionfont",  insertText = snippet:get "tex/preamble-sectionfont.tex" },
		{ label = ":settings",     insertText = snippet:get "tex/preamble-package.tex" },
		{ label = ":shruggie",     insertText = snippet:get "tex/preamble-shruggie.tex" },
		{ label = ":sign",         insertText = snippet:get "tex/preamble-sign.tex" },
		{ label = ":tikz",         insertText = snippet:get "tex/preamble-tikz.tex" },
		{ label = ":toc",          insertText = snippet:get "tex/preamble-tableofcontents.tex" },
		{ label = ":underdot",     insertText = snippet:get "tex/preamble-underdotxe.tex" },
		{ label = ":verbatim",     insertText = snippet:get "tex/preamble-fancyvrb.tex" },
		{ label = ":date",         insertText = snippet:get "tex/preamble-datetime.tex" },
		{ label = ":dinkus",       insertText = snippet:get "tex/preamble-dinkus.tex" },
		{ label = ":glossary",     insertText = snippet:get "tex/preamble-glossaries.tex" },
		{ label = ":beamertheme",  insertText = snippet:get "tex/preamble-beamer_theme.tex" },
		{ label = ":tcolorbox",    insertText = snippet:get "tex/preamble-tcolorbox.tex" },
		{ label = ":minted",       insertText = snippet:get "tex/preamble-minted.tex" },
		{ label = ":blind",        insertText = snippet:get "tex/indoc-blindtext.tex" },
		{ label = ":blindchinese", insertText = snippet:get "tex/indoc-blindtext-zh.tex" },
		-- ENVIRONMENTS:
		snippet.snippet { label = ":bfigure",     insertText = snippet:get "tex/env-figure.snippet.tex" },
		snippet.snippet { label = ":subfigure",   insertText = snippet:get "tex/env-subfigure.snippet.tex" },
		snippet.snippet { label = ":btable",      insertText = snippet:get "tex/env-table.snippet.tex" },
		snippet.snippet { label = ":csv",         insertText = snippet:get "tex/env-csv.snippet.tex" },
		snippet.snippet { label = ":minipage",    insertText = snippet:get "tex/env-minipage.snippet.tex" },
		snippet.snippet { label = ":iff",         insertText = snippet:get "tex/env-iff.snippet.tex" },
		snippet.snippet { label = ":begin",       insertText = environment {} },
		snippet.snippet { label = ":matrix",      insertText = environment { env = "matrix" } },
		snippet.snippet { label = ":cases",       insertText = environment { env = "cases*" } },
		snippet.snippet { label = ":aligned",     insertText = environment { env = "aligned" } },
		snippet.snippet { label = ":balign",      insertText = environment { env = "align*" } },
		snippet.snippet { label = ":gather",      insertText = environment { env = "gather*" } },
		snippet.snippet { label = ":equation",    insertText = environment { env = "equation*" } },
		snippet.snippet { label = ":equations",   insertText = environment { env = "equations*" } },
		snippet.snippet { label = ":matrix",      insertText = environment { env = "matrix*" } },
		snippet.snippet { label = ":bmatrix",     insertText = environment { env = "bmatrix*" } },
		snippet.snippet { label = ":vmatrix",     insertText = environment { env = "vmatrix*" } },
		snippet.snippet { label = ":block",       insertText = environment { env = "block", append = "{$1}" } },
		snippet.snippet { label = ":frame",       insertText = environment { env = "frame", append = "{$1}" } },
		snippet.snippet { label = ":multicols",   insertText = environment { env = "multicols", append = "{${1:2}}${2:[Text across columns]}" } },
		snippet.snippet { label = ":algorithmic", insertText = environment { env = "algorithmic", append = "[1]" } },
		snippet.snippet { label = ":itemize",     insertText = environment { env = "itemize", content = "\t\\item\n" .. "\t\t$0" } },
		snippet.snippet { label = ":enumerate",   insertText = environment { env = "enumerate", content = "\t\\item\n" .. "\t\t$0" } },
		snippet.snippet {
			label = ":enumeratelabel",
			insertText = environment {
				env = "enumerate",
				content = "\t\\item\n" .. "\t\t$0",
				append = "[label=${1:(\\\\alph*)}]"
			}
		},
		-- MATH:
		snippet.snippet { label = ":sum",  insertText = "\\sum_{${1:i=1}}^{${2:n}}$0" },
		snippet.snippet { label = ":prod", insertText = "\\prod_{${1:i=1}}^{${2:n}}$0" },
		snippet.snippet { label = ":frac", insertText = "\\frac{$1}{$2}$0" },
		-- MATH NOTES:
		snippet.snippet { label = ":corollary",   insertText = environment { env = "corollary", append = "\\label{cor-$1}" } },
		snippet.snippet { label = ":definition",  insertText = environment { env = "definition", append = "\\label{def-$1}" } },
		snippet.snippet { label = ":eg",          insertText = environment { env = "example", append = "\\label{eg-$1}" } },
		snippet.snippet { label = ":lemma",       insertText = environment { env = "lemma", append = "\\label{lem-$1}" } },
		snippet.snippet { label = ":proof",       insertText = environment { env = "proof" } },
		snippet.snippet { label = ":proposition", insertText = environment { env = "proposition", append = "\\label{prop-$1}" } },
		snippet.snippet { label = ":remark",      insertText = environment { env = "remark", append = "\\label{rem-$1}" } },
		snippet.snippet { label = ":theorem",     insertText = environment { env = "theorem", append = "[$1]\\label{thm-$2}" } },
		snippet.snippet { label = ":assumption",  insertText = environment { env = "assumption", append = "[$1]\\label{ass-$2}" } },
		snippet.snippet { label = ":claim",       insertText = environment { env = "claim" } },
		snippet.snippet { label = ":axiom",       insertText = environment { env = "axiom", append = "[$1]\\label{axm-$2}" } },
		-- TIKZ:
		snippet.snippet { label = ":tikz",             insertText = snippet:get "tex/env-tikz.snippet.tex" },
		snippet.snippet { label = ":tikzintersection", insertText = "\\path[name intersections={of= $1 and $2}]; % (intersection-1)" },
		-- MISC:
		snippet.snippet { label = ":columnbreak",   insertText = "\\vfill\\null\\columnbreak" },
		snippet.snippet { label = ":verbatiminput", insertText = "\\VerbatimInput[${1:frame=single,numbers=left}]{$0}" },
	}
	callback(items)
end

return source
