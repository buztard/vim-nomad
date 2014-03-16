" nomad.vim
" Author:  Bastian Winkler <buz@netbuz.org>
" Repo:    https://github.com/buztard/vim-nomad
" Version: 0.1
" Licence: Same terms as Vim itself

if exists("g:autoloaded_nomad") || !executable('tmux')
    finish
endif
let g:autoloaded_nomad = 1

if !exists('g:nomad_reconnect_display')
    let g:nomad_reconnect_display = 1
endif

function! nomad#get_env() abort
    let pairs = split(system('tmux show-environment'), '\n')
    let env = {}
    for pair in pairs
	if pair[0] == '-'
	    " Vim cannot remove environment variables, skip them
            continue
	endif
	" let name = matchstr(pair, '^\w\+\ze=')
	" let value = matchstr(pair, '^\w\+=\zs.*\ze')
	let var = split(pair, '=')
	let name = var[0]
	let value = join(var[1:], '=')
	let env[name] = value
    endfor
    return env
endfunction

function! nomad#complete(A, L, P) abort
    let env = nomad#get_env()
    let matches = []
    echom a:A
    echom a:L
    echom a:P
    for name in sort(keys(env))
	if (len(a:A) == 0 || match(name, a:A) == 0) && match(a:L, '\<'.name.'\>') == -1
	    let matches += [name]
	endif
    endfor
    return matches
endfunction

function! nomad#update_env(arg)
    if !exists("$TMUX")
        echohl WarningMsg
	echom "UpdateEnv must be run in a tmux environment"
	echohl None
	return
    endif
    let env = nomad#get_env()
    if len(a:arg)
	let vars = split(a:arg)
    elseif exists('g:nomad_default_variables')
	let vars = g:nomad_default_variables
    else
	let vars = keys(env)
    endif
    for name in vars
	if !has_key(env, name)
	    echohl WarningMsg
	    echo "Tmux doesn't provide '" . name . "' variable'"
	    echohl None
	    continue
	endif
        execute "let $".name." = '".env[name]."'"
        " echom "Updated ".name." = '".env[name]."'"
    endfor
    if g:nomad_reconnect_display == 1
	" Small workaround to reconnect to the X display
	call serverlist()
    endif
endfunction
