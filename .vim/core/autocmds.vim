" Basic vim setup 🧠

" - auto-reload files
augroup AutoReload
    autocmd!
    " Auto-check file changes when returning to vim or switching buffers
    autocmd FocusGained,BufEnter * checktime
augroup END

" Editing hygiene 🧹

" - strip trailing whitespace on save and restore cursor position when reopening files
augroup GeneralAutocmds
  autocmd!

  " -- remove trailing whitespace on save
  autocmd BufWritePre * silent! %s/\s\+$//e

  " -- restore last cursor position when reopening files
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif
augroup END
