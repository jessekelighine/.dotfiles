" ~/.vim/after/ftplugin/tex/tikz.vim

" " TIKZ: tikz package.
imap <buffer> \tikz<Tab> <Esc>:call my#GetSnippets("tex","indoc_tikz.tex")<CR>
imap <buffer> :ang<Tab>  <Esc>:call my#GetSnippets("tex","preamble_tikz_angles.tex")<CR>
imap <buffer> :blob<Tab> <C-G>u\newcommand{\blob}[2]{\draw[fill,rounded corners=#1*1mm] (#2) +($(0:#1*2+#1*rnd)$) \foreach \a in {20,40,...,350} { -- +($(\a: #1*2+#1*rnd)$) } -- cycle;}
imap <buffer> :bg<Tab>   <C-G>u\pgfdeclarelayer{background}<CR>\pgfsetlayers{background,main}

imap <buffer> \int<Tab>      <C-G>u\path[name intersections={of=and}]; % (intersection-1)<Esc>F=
imap <buffer> \ang<Tab>      <C-G>u\pgfmathsetmacro<++>{atan2(<++>)};<esc>F\<leader>]
imap <buffer> \pic<Tab>      <C-G>upic[pos=]{code={<++>}}<esc>F]i
imap <buffer> {{{<Tab>       <C-G>u%% {{{<CR>%% }}}<Up><Esc>B
imap <buffer> \bisector<Tab> <C-G>u\draw[red] (A) -- ($($(A)!1cm!(B)$)!0.5!($(A)!1cm!(C)$)$);<Esc>
imap <buffer> \perpfoot<Tab> <C-G>u($(A)!(B)!(C)$)<Esc>
