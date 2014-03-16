if exists("g:loaded_nomad") || !executable('tmux')
    finish
endif
let g:loaded_nomad = 1

command! -nargs=* -complete=customlist,nomad#complete UpdateEnv execute nomad#update_env(<q-args>)
