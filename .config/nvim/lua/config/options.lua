-- Zakladni nastaveni Neovimu

-- Mezery misto tabulatoru
vim.opt.expandtab = true
-- Velikost odsazeni (stisknuti Tab nebo << >>)
vim.opt.shiftwidth = 4
-- Na kolik mezer se zobrazi znak Tab
vim.opt.tabstop = 4
-- Kolik mezer se vlozi pri stisknuti Tab
vim.opt.softtabstop = 4

-- Chytre odsazovani podle typu souboru
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Zalamovani radku se zachovanim odsazeni
vim.opt.breakindent = true

-- Cislovani radku (kombinace cisla a relativniho cisla)
vim.opt.number = true
vim.opt.relativenumber = true

-- Zvyrazneni radku, na kterem je kurzor
vim.opt.cursorline = true

-- Historie zmen se uklada i po zavreni souboru (velmi uzitecne!)
vim.opt.undofile = true

-- Zapnuti mysi (hodne se hodi na resizovani oken nebo scroll)
vim.opt.mouse = "a"

-- Skryje vypis modu (-- INSERT --), protoze ho uvidis ve statusline (lualine)
vim.opt.showmode = false

-- Nastaveni vyhledavani
vim.opt.ignorecase = true -- Ignorovat velka/mala pismena
vim.opt.smartcase = true -- Pokud napises velke pismeno, zacne ho to brat v potaz

-- Sloupec se znamky (napr. chyby z LSP nebo Git ikony) bude vzdy videt
vim.opt.signcolumn = "yes"

-- Rozdelovani oken (nove okno se otevre vpravo/dole)
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Zobrazeni neviditelnych znaku (tabulatory, mezery na konci radku)
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Minimalni pocet radku, ktere vzdy uvidis nad/pod kurzorem pri scrollovani
vim.opt.scrolloff = 5

-- Skryti varovani o zastaralych funkcich (deprecated)
vim.g.deprecation_warnings = false

-- Nastaveni pro praci s textem
vim.opt.wrap = true -- Zalamovat radky, co jsou moc dlouhe
vim.opt.linebreak = true -- Nelamat slova v pulce

-- Nastaveni pro lepsi cteni a psani textu (Markdown)
-- - schova znacky jako **tucne** nebo odkazy
vim.opt.conceallevel = 2
-- - schova ohraniceni pro schovany text
vim.opt.concealcursor = "nc"
