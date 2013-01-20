" Vim plugin for #ifdef object
" Maintainer: INAJIMA Daisuke <inajima@sopht.jp>
" Version: 0.1

let s:save_cpo = &cpo
set cpo&vim

function! textobj#ifdef#select_a()
    return s:select(0)
endfunction

function! textobj#ifdef#select_i()
    return s:select(1)
endfunction

function! s:select(inner)
    let c = v:count1

    let p = ['^\s*#\s*if\%[def]\>', '^\s*#\s*el\(if\|se\)\>', '^\s*#\s*endif\>']
    if !a:inner
        let p[1] = ''
    endif

    if getline('.') =~# p[2]
        normal! k
    endif

    normal! $

    while c > 0
        let [sl, _] = searchpairpos(p[0], p[1], p[2], 'bW')
        let c -= 1
    endwhile

    let [el, _] = searchpairpos(p[0], p[1], p[2], 'nW')

    if sl == 0 || el == 0
        return 0
    endif

    if a:inner
        let sl += 1
        let el -= 1
    endif

    return ['V', [0, sl, 1, 0], [0, el, 1, 0]]
endfunction

function! textobj#ifdef#surround_input()
    let macro = input('#if ')
    if macro == ''
        return []
    elseif macro =~# '\v^[A-Za-z_][0-9A-Za-z_]*$'
        let macro = 'def ' . macro
    else
        let macro = ' ' . macro
    endif
    return [macro]
endfunction

let &cpo = s:save_cpo
