" Basic vim setup 🧠

" - enable syntax highlighting
syntax on
syntax enable

" UI & theme setup 🎨

" Oprava pruhlednosti pro XMonad/Picom
function! AdaptColorscheme()
    highlight Normal guibg=NONE ctermbg=NONE
    highlight SignColumn guibg=NONE
    highlight LineNr guibg=NONE
    highlight CursorLineNr guibg=NONE
    highlight EndOfBuffer guibg=NONE
    " Pro Catppuccin konkretne, aby byly videt svisle cary rozdeleni oken
    highlight VertSplit guibg=NONE guifg=#45475a
endfunction

augroup TransparencyFix
    autocmd!
    autocmd ColorScheme * call AdaptColorscheme()
augroup END

" Nastaveni Catppuccin (Mocha je nejtmavsi a nejvic 'Doom-like')
let g:catppuccin_flavour = 'macchiato'

" Gruvbox material options: style and performance
" - colorscheme je: gruvbox-material
" - airline-theme je: gruvbox_material
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_transparent_background = 0

" Load colorscheme
colorscheme catppuccin_mocha

" Match airline theme with the current colorscheme
let g:airline_theme='bubblegum'
