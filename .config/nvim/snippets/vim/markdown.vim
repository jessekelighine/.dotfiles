" vimrc

let b:markdown_view_file = substitute(
			\ expand("%:p"),
			\ expand("%:e") .. "$",
			\ "html", "")
