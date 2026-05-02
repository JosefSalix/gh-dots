" CSV settings 📊

augroup CSVSetup
    autocmd!
    " - zajisteni, ze se sloupce nebudou zalamovat (lepe se v tom orientuje)
    autocmd FileType csv setlocal nowrap
    " - ponechani  tabulatoru, pokud v souboru jsou
    autocmd FileType csv setlocal noexpandtab
    " - vypnuti C-indentace, ktera by mohla u CSV zlobit
    autocmd FileType csv setlocal nocindent

    " - mapovani pro RBQL (SQL dotazy nad CSV) - tvuj leader je mezera
    autocmd FileType csv nnoremap <buffer> <leader>rq :RBQL<CR>
augroup END

" globalni nastaveni pro rainbow_csv (mimo autocmd)
" zobrazeni nazvu a indexu sloupce ve stavovem radku (ladi s tvym airline) [cite: 10]
let g:disable_rainbow_hover = 0

" SQL settings 🗄️

augroup SQLSetup
    autocmd!
    autocmd FileType sql setlocal tabstop=4 shiftwidth=4 expandtab
    autocmd FileType sql setlocal commentstring=--\ %s
augroup END
