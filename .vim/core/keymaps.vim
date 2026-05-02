" Key mapppings 🔐
" - leader system: f=files, b=buffers, w=windows, m=markdown.

" - leader key
let mapleader = " "

" - files (f)
nnoremap <leader>fw :w<CR>
nnoremap <leader>fq :q<CR>
nnoremap <leader>fx :x<CR>

" - windows/splits (w)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" - markdown (m)
augroup MarkdownMappings
  autocmd!
  autocmd FileType markdown nnoremap <buffer> <leader>mp :MarkdownPreview<CR>
  autocmd FileType markdown nnoremap <buffer> <leader>ms :MarkdownPreviewStop<CR>
  autocmd FileType markdown nnoremap <buffer> <leader>mt :GenTocGFM<CR>
  autocmd FileType markdown nnoremap <buffer> <leader>mu :UpdateToc<CR>
  autocmd FileType markdown nnoremap <buffer> <leader>mg :Goyo<CR>
augroup END

" - resize splits
nnoremap <silent> <leader>w+ :resize +5<CR>
nnoremap <silent> <leader>w- :resize -5<CR>
nnoremap <silent> <leader>w> :vertical resize +5<CR>
nnoremap <silent> <leader>w< :vertical resize -5<CR>

" - buffers
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" - better movement on wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" - visual indent: keep selection
vnoremap < <gv
vnoremap > >gv

" - move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" - auto-pairs
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>
inoremap ' ''<Left>

" - reload vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" Search behavior 🔎
" - clear search highlight by pressing <leader>h
nnoremap <leader>h :noh<CR>

" Vimwiki 🗃️
" - open today's journal entry + add link to journal/index.md (newest first)
nnoremap <leader>jj :call JournalToday()<CR>

" Indentation for c++ or languages in general (test)
nnoremap <leader>= gg=G
nnoremap <leader>f :%!clang-format<CR>
