"=============================================================================
" What Is This: Add some conceal operator for your OCaml files
" File:         ocaml.vim (conceal enhancement)
" Author:       Vincent Berthoux <twinside@gmail.com>
" Version:      1.0
" Require:
"   set nocompatible
"     somewhere on your .vimrc
"
"   Vim 7.3 or Vim compiled with conceal patch.
"   Use --with-features=big or huge in order to compile it in.
"
" Usage:
"   Drop this file in your
"       ~/.vim/after/syntax folder (Linux/MacOSX/BSD...)
"       ~/vimfiles/after/syntax folder (Windows)
"
"   For this script to work, you have to set the encoding
"   to utf-8 :set enc=utf-8
"
" Additional:
"     * if you want to avoid the loading, add the following
"       line in your .vimrc :
"        let g:no_ocaml_conceal = 1
"
"     * Avoid concealing float operators (+., -., /., *.)
"        let g:no_ocaml_conceal_float_operators = 1
"
"     * Avoid concealing common type variables
"        let g:no_ocaml_conceal_type_variables = 1
" Changelog:
"
if exists('g:no_ocaml_conceal') || !has('conceal') || &enc != 'utf-8'
    finish
endif

" vim: set fenc=utf-8:
syntax match ocamlNiceOperator "->" conceal cchar=→
syntax match ocamlNiceOperator "\<sum\>" conceal cchar=∑
syntax match ocamlNiceOperator "\<product\>" conceal cchar=∏ 
syntax match ocamlNiceOperator "\<sqrt\>" conceal cchar=√ 
syntax match ocamlNiceOperator "\<pi\>" conceal cchar=π
syntax match ocamlNiceOperator "\<fun\>" conceal cchar=λ

" Because it's annoying when reading code, points are distracting. :|
if !exists('g:no_ocaml_conceal_float_operators')
    syntax match ocamlNiceOperator "*\." conceal cchar=*
    syntax match ocamlNiceOperator "/\." conceal cchar=/
    syntax match ocamlNiceOperator "+\." conceal cchar=+
    syntax match ocamlNiceOperator "-\." conceal cchar=-
endif

" Because I find greek letters prettier than 'a and 'b
if !exists('g:no_ocaml_conceal_type_variables')
    syntax match ocamlNiceType "'a\>" conceal cchar=α
    syntax match ocamlNiceType "'b\>" conceal cchar=β
    syntax match ocamlNiceType "'c\>" conceal cchar=γ
    syntax match ocamlNiceType "'d\>" conceal cchar=δ
endif

let s:extraConceal = 1
" Some windows font don't support some of the characters,
" so if they are the main font, we don't load them :)
if has("win32")
    let s:incompleteFont = [ 'Consolas'
                        \ , 'Lucida Console'
                        \ , 'Courier New'
                        \ ]
    let s:mainfont = substitute( &guifont, '^\([^:,]\+\).*', '\1', '')
    for s:fontName in s:incompleteFont
        if s:mainfont ==? s:fontName
            let s:extraConceal = 0
            break
        endif
    endfor
endif

if s:extraConceal
    syntax match ocamlNiceOperator "\:\:" conceal cchar=∷
endif

hi link ocamlNiceOperator Operator
hi link ocamlNiceType Operator
hi! link Conceal Operator
setlocal conceallevel=2

