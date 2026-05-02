" Org mode 🦖

" - detect .org files and enable OrgMode folding using expression-based folds
augroup OrgModeSetup
  autocmd!

  " -- detect org files
  autocmd BufRead,BufNewFile *.org setfiletype org

  " -- org folding (vim-orgmode)
  autocmd FileType org setlocal foldmethod=expr
  autocmd FileType org setlocal foldexpr=OrgModeFold(v:lnum)
  autocmd FileType org setlocal foldlevel=1

  " -- comfortable wrapping for org notes
  autocmd FileType org setlocal wrap linebreak breakindent
augroup END