" Markdown workflow 📝

" - detect markdown files (usually automatic, but kept for reliability)
augroup FiletypesMarkdown
  autocmd!
  autocmd BufNewFile,BufRead *.md setfiletype markdown
augroup END

" - vim-markdown
" -- disable plugin folding (we use marker folding)
let g:vim_markdown_folding_disabled = 1

" - markdown buffer settings
augroup MarkdownSetup
  autocmd!

  " -- folding: use {{{ }}} markers
  autocmd FileType markdown setlocal foldmethod=marker
  autocmd FileType markdown setlocal foldmarker={{{,}}}

  " -- comfortable wrapping for prose
  autocmd FileType markdown setlocal wrap linebreak breakindent

  " -- conceal (hide markdown syntax for cleaner look)
  autocmd FileType markdown setlocal conceallevel=2
  autocmd FileType markdown setlocal concealcursor=nc

  " -- text width for nicer formatting
  autocmd FileType markdown setlocal textwidth=80

  " -- toggle TableMode only in markdown buffers
  autocmd FileType markdown nnoremap <buffer> <leader>tm :TableModeToggle<CR>
augroup END

" - vim-markdown toc
let g:vmt_auto_update_on_save = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'

" - vim table mode
let g:table_mode_corner='|'
let g:table_mode_corner_corner='|'
let g:table_mode_header_fillchar='='

" - bullets.vim
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'scratch'
    \ ]

" - vim pencil
augroup PencilSetup
  autocmd!
  autocmd FileType markdown call pencil#init({'wrap': 'soft'})
  autocmd FileType text     call pencil#init({'wrap': 'soft'})
augroup END

" - markdown preview.nvim
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_browser = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle'
    \ }

" Skryje hastagy u nadpisu a nahradi je mezerou (vypada to cisteji)
let g:vim_markdown_conceal_hashtags = 1
