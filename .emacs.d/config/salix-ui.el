;;; salix-ui.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi vizualni prvky Emacsu - zvoneni, okraje, scrollovani a zavorky.
;; Obsahuje nastaveni ktere plati globalne pro cely editor.

;;; Code:

;; Vypnuti uvodni obrazovky a zprav pri startu
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message user-login-name)

;; Vizualni zvoneni misto zvuku
(setq visible-bell t)

;; Sirka okraju (fringe) vlevo a vpravo od bufferu
(set-fringe-mode 15)

;; Zobrazeni cisla sloupce v mode-line
(column-number-mode 1)

;; Automaticke zalamovani radku v textovych modech
(dolist (mode-hook '(text-mode-hook
                     markdown-mode-hook))
  (add-hook mode-hook #'auto-fill-mode))

;; Zvyrazneni sparovanych zavorek
;; - mixed: zvyrazni zavorku nebo obsah podle toho co je viditelne
(show-paren-mode 1)
(setq show-paren-delay 0.1
      show-paren-style 'mixed)

;; Automaticke doplnovani parovych znaku - (), "", atd.
;; - vyjimky: < a ' (v elispu a textu by automaticke doplneni vadilo)
(electric-pair-mode 1)
(setq electric-pair-inhibit-predicate
      (lambda (c)
        (if (member c '(?< ?'))
            t
          (electric-pair-default-inhibit c))))

;; Plynule scrollovani
;; - margin 3: kurzor vzdy 3 radky od okraje
;; - conservatively: scrolluje po radku, ne po pulstrankach
(setq scroll-margin 3
      scroll-conservatively 101
      scroll-preserve-screen-position t)

;; Optimalizace pro dlouhe radky (Emacs 29+)
;; - nad 1000 znaku se vypnou nektere narocne operace
(when (>= emacs-major-version 29)
  (setq-default long-line-threshold 1000
                large-hscroll-threshold 1000
                syntax-wholeline-max 1000))

;; Barveni zavorek podle hloubky vnoreni v programovacich modech
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(provide 'salix-ui)

;;; salix-ui.el ends here
