" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Ron Aaron <ron@ronware.org>
" Last Change:	2003 May 02

hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "pablo2"

highlight Comment	 ctermfg=1						  guifg=#ffffff
highlight Constant	 ctermfg=1			   cterm=none guifg=#ffffff				  gui=none
highlight Identifier ctermfg=1						  guifg=#ffffff
highlight Statement  ctermfg=1			   cterm=bold guifg=#ffffff				  gui=bold
highlight PreProc	 ctermfg=1						  guifg=#ffffff
highlight Type		 ctermfg=1						  guifg=#ffffff
highlight Special	 ctermfg=1						  guifg=#ffffff
highlight Error					ctermbg=1							guibg=#ffffff
highlight Todo		 ctermfg=1	ctermbg=1			  guifg=#ffffff guibg=#ffffff
highlight Directory  ctermfg=1						  guifg=#ffffff
highlight StatusLine ctermfg=1 ctermbg=1 cterm=none guifg=#ffffff guibg=#ffffff gui=none
highlight Normal									  guifg=#ffffff guibg=#ffffff
highlight Search				ctermbg=1							guibg=#ffffff
