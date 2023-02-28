" ftplugin/tex.vim

if !exists('g:emmetex_lists')    | let g:emmetex_lists    = ['enum', 'item'] | endif
if !exists('g:emmetex_nomap')    | let g:emmetex_nomap    = 0                | endif
if !exists('g:emmetex_trigger')  | let g:emmetex_trigger  = '<C-Y>'          | endif
if !exists('g:emmetex_register') | let g:emmetex_register = 9                | endif

exe join(['inoremap','<Plug>(EmmeTeXTrigger)','<C-G>u<Esc>$v_"'.g:emmetex_register.'y0"_D:call<Space>emmetex#Emmet(@9)<CR>'],' ')

if !g:emmetex_nomap | exe join(['imap','<buffer>',g:emmetex_trigger,'<Plug>(EmmeTexTrigger)'],' ') | endif

" TexEmmet: custom dictionary.
let g:emmetex_lists = [ 'en', 'ena', 'enr', 'it' ]
let g:emmetex_dict  = {
			\ 'doc'  : { 'env': 'document',    'opt': '', 'ins': [] },
			\ 'en'   : { 'env': 'enumerate',   'opt': '', 'ins': [] },
			\ 'ena'  : { 'env': 'enumerate',   'opt': '[label = (\alph*)]', 'ins': [] },
			\ 'enr'  : { 'env': 'enumerate',   'opt': '[label = (\roman*)]', 'ins': [] },
			\ 'it'   : { 'env': 'itemize',     'opt': '', 'ins': [] },
			\ 'ba'   : { 'env': 'align*',      'opt': '', 'ins': [] },
			\ 'al'   : { 'env': 'aligned',     'opt': '', 'ins': [] },
			\ 'eq'   : { 'env': 'equation',    'opt': '', 'ins': [] },
			\ 'ga'   : { 'env': 'gather',      'opt': '', 'ins': [] },
			\ 'fr'   : { 'env': 'frame',       'opt': '[]', 'ins': [] },
			\ 'bl'   : { 'env': 'block',       'opt': '', 'ins': [] },
			\ 'sc'   : { 'env': 'scope',       'opt': '', 'ins': [] },
			\ 'pb'   : { 'env': 'problem*',    'opt': '[]', 'ins': [] },
			\ 'pf'   : { 'env': 'proof',       'opt': '', 'ins': [] },
			\ 'eg'   : { 'env': 'example',     'opt': '', 'ins': [] },
			\ 'dfn'  : { 'env': 'definition',  'opt': '', 'ins': [] },
			\ 'thm'  : { 'env': 'theorem',     'opt': '', 'ins': [] },
			\ 'lem'  : { 'env': 'lemma',       'opt': '', 'ins': [] },
			\ 'clm'  : { 'env': 'claim',       'opt': '', 'ins': [] },
			\ 'prop' : { 'env': 'proposition', 'opt': '', 'ins': [] },
			\ 'cor'  : { 'env': 'corollary',   'opt': '', 'ins': [] },
			\ 'ass'  : { 'env': 'assumption',  'opt': '', 'ins': [] },
			\ 'rmk'  : { 'env': 'remark',      'opt': '', 'ins': [] },
			\ 'iff'  : { 'env': 'itemize',     'opt': '', 'ins': ['\item[$(\Rightarrow)$]', '\item[$(\Leftarrow)$]'] },
			\ 'iffc' : { 'env': 'itemize',     'opt': '', 'ins': ['\item[$(\subset)$]', '\item[$(\supset)$]'] },
			\ 'tikz' : { 'env': 'tikzpicture', 'opt': '[scale=1/2,thick,line cap=round]', 'ins': ['\tikzstyle{jiao}=[solid,circle,draw,fill=white,inner sep=.8pt];'] },
			\ 'bfig' : { 'env': 'figure',      'opt':'[t]', 'ins':['\centering', '\includegraphics[scale=1]{}', '\caption{}', '\label{fig:}'] },
			\ 'btab' : { 'env': 'table',       'opt':'[t]', 'ins':['\centering', '\begin{tabular}{}', '\toprule', '\midrule', '\bottomrule', '\end{tabular}', '\caption{}', '\label{tab:}'] },
			\ 'mat'  : { 'env': 'bmatrix',     'opt':'', 'ins':[] },
			\ 'vmat' : { 'env': 'vmatrix',     'opt':'', 'ins':[] },
			\ 'cols' : { 'env': 'multicols*',  'opt':'{2}', 'ins':[] },
			\ }
inoremap <buffer> \ba<Tab>  <Esc>:call emmetex#Emmet('ba')<CR>o
inoremap <buffer> \ali<Tab> <Esc>:call emmetex#Emmet('al')<CR>o
