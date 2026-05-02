" Basic vim setup 🧠

" - auto-reload files changed outside of vim
set autoread

" - enable filetype detection + plugins + indentation
filetype on
filetype plugin on
filetype indent on

" UI & theme setup 🎨

" - enable  24-bit (true) colors in terminal vim
set termguicolors

" - prefer dark backround
set background=dark

" UI feedback 👀

" - show absolute + relative line numbers
set number
set relativenumber

" - highlight matching brackets briefly
set showmatch
set matchtime=2

" - show current mode, typed commands and cursor position
set noshowmode
set showcmd
set ruler

" - always show statusline
set laststatus=2

" Indentation 🧱

" - use 4 spaces per indent level (tabs are converted to spaces)
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" - smarter tab behavior while indenting
set smarttab

" - automatically copy indentation from current line
set autoindent

" - smarter indentation for C-like code structures
" set smartindent  " presunuto do indent.vim (vypnuto)

" Wrapping & long lines 📃

" - wrap long lines on screen (no horizontal scrolling)
set wrap

" - wrap at word boundaries (do not split words)
set linebreak

" - keep indentation on wrapped lines for better readability
set breakindent

" - show a marker at the start of wrapped lines
set showbreak=↪\

" Search behavior 🔎

" - case-insensitive search, unless uppercase letters are used
set ignorecase
set smartcase

" - highlight all search matches
set hlsearch

" - show matches while typing the search pattern
set incsearch

" - do not wrap search to the beginning/end of the file
set nowrapscan

" Performance & ui responsivness 🛞

" - speed up screen redraw (especially during macros)
set lazyredraw
set ttyfast

" - faster CursorHold events (useful for plugins like LSP)
set updatetime=300

" - reduce delay for mappings and key sequences
set timeoutlen=500
set ttimeoutlen=10

" - keep some context around cursor while moving
set scrolloff=8
set sidescrolloff=8

" Command-line completion ⌨️

" - show command-line completion menu
set wildmenu

" - completion behavior:
" -- first tab completes as far as possible
" -- next tabs cycle through full matches
set wildmode=longest:full,full

" - ignore common binary/cache/temp files in completion
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.swp,*.zip,*.tar.gz
set wildignore+=*/node_modules/*,*/.git/*,*/dist/*,*/build/*
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.svg,*.pdf

" History & undo 🌪️

" - remember lots of command-line and search history
set history=1000

" - allow deep undo (many undo steps)
set undolevels=1000

" - keep undo info when reloading a file (buffer reload)
set undoreload=10000

" Splits & usability 🪟

" - open new splits in a more natural direction
set splitbelow
set splitright

" - enable mouse support in all modes
set mouse=a

" - use system clipboard for copy/paste
set clipboard+=unnamedplus

" - reduce command-line messages
set shortmess+=cI

" Backup & Swap & Undo files 💾
" - store vim temporary files in dedicated directories
" -- mkdir -p ~/.vim/tmp ~/.vim/backup ~/.vim/undo

" - put swap files into ~/.vim/tmp
set directory^=$HOME/.vim/tmp//

" - store backup files in ~/.vim/backup
set backupdir^=$HOME/.vim/backup//

" - store undo history in ~/.vim/undo
set undodir^=$HOME/.vim/undo//

" - enable persistent undo across vim sessions
set undofile

" - enable backup file creation
set backup

" Modelines & Security 🔓

" - enable modelines
set modeline

" - scan first/last 2 lines for modelines
set modelines=2

" - restrict what modelines can do (security)
set secure
