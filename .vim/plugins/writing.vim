" Writing workflow 📝

" - vim pencil
augroup PencilSetup
  autocmd!
  autocmd FileType markdown call pencil#init({'wrap': 'soft'})
  autocmd FileType text     call pencil#init({'wrap': 'soft'})
augroup END

" - focus mode: goyo + limelight
let g:goyo_width = 100
let g:goyo_height = 90
let g:limelight_conceal_ctermfg = 240

augroup GoyoLimelight
  autocmd!
  autocmd User GoyoEnter Limelight
  autocmd User GoyoLeave Limelight!
augroup END