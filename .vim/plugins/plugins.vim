" Plugins (vim-plug) 🧩

call plug#begin('~/.vim/plugged')

" - markdown & notes
Plug 'preservim/vim-markdown', {'for': 'markdown'}
Plug 'mzlogin/vim-markdown-toc', {'for': 'markdown'}
Plug 'dkarter/bullets.vim'
Plug 'dhruvasagar/vim-table-mode', {'for': 'markdown'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install', 'for': 'markdown' }

" - writing & focus mode
Plug 'preservim/vim-pencil'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" - snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" csv tooling
Plug 'mechatroner/rainbow_csv', {'for': 'csv'}

" - statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" - colorschemes
Plug 'sainnhe/gruvbox-material'
Plug 'arcticicestudio/nord-vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

" - org-mode
Plug 'jceb/vim-orgmode', {'for': 'org'}

" - language packs & syntax
" -- disable Polyglot org syntax (using vim-orgmode instead)
let g:polyglot_disabled = ['org']
Plug 'sheerun/vim-polyglot'

" - small productivity helpers
Plug 'tpope/vim-speeddating'

" - lsp
Plug 'prabirshrestha/vim-lsp'

" - git-fugitive
Plug 'tpope/vim-fugitive'

call plug#end()
