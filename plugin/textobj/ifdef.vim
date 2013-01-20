" Vim plugin for #ifdef object
" Maintainer: INAJIMA Daisuke <inajima@sopht.jp>
" Version: 0.1

if exists("g:loaded_textobj_ifdef")
    finish
endif
let g:loaded_textobj_ifdef = 1

let s:save_cpo = &cpo
set cpo&vim

call textobj#user#plugin('ifdef', {
\   '-': {
\       '*select-a-function*': 'textobj#ifdef#select_a',
\       '*select-i-function*': 'textobj#ifdef#select_i',
\       'select-a': ['a#', 'a3'],
\       'select-i': ['i#', 'i3'],
\   },
\})

let s:surround_objects = {
\   "#": {
\       'left': "\n#if\1\n", 'right': "\n#endif\n", 'nspaces': 0, 'reindent': 0,
\       'inputfunc': 'textobj#ifdef#surround_input'
\   },
\   "3": {
\       'left': "\n#if\1\n", 'right': "\n#endif\n", 'nspaces': 0, 'reindent': 0,
\       'inputfunc': 'textobj#ifdef#surround_input'
\   },
\}

if !exists("g:textobj_ifdef_surround") || g:textobj_ifdef_surround
    if !exists("g:surround_objects")
        let g:surround_objects = {}
    endif
    call extend(g:surround_objects, s:surround_objects, "keep")
endif

let &cpo = s:save_cpo
