" nomad.vim
" Author:  Bastian Winkler <buz@netbuz.org>
" Repo:    https://github.com/buztard/vim-nomad
" Version: 0.1
" Licence: Same terms as Vim itself

if exists("g:loaded_nomad") || !executable('tmux')
    finish
endif
let g:loaded_nomad = 1

command! -nargs=* -complete=customlist,nomad#complete UpdateEnv execute nomad#update_env(<q-args>)
