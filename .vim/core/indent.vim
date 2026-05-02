" Indentation engine 🧠

" zapnout filetype indent (důležité)
filetype plugin indent on

" základ
set autoindent

" C-like jazyky (C, C++, Java…)
set cindent

" vypnout smartindent (může kolidovat)
set nosmartindent

" jemné doladění indentu
set cinoptions+=j1

" lepší chování při Enteru a komentářích
set formatoptions+=cro
