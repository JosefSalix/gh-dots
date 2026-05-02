;;; salix-languages.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Definuje major mody pro jednotlive programovaci jazyky.
;; Balicky se nacitaji az pri otevreni prislusneho souboru (:mode).

;;; Code:

;; Python
;; - ensure nil: vestaveny balik
;; - python3 jako vychozi interpret
;; - vypnuti varovani o odsazeni
(use-package python
  :ensure nil
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)
  :config
  (setq python-shell-interpreter "python3"
        python-indent-guess-indent-offset-verbose nil))

;; Go a Lua
(use-package go-mode
  :mode ("\\.go\\'" . go-mode))

(use-package lua-mode
  :mode ("\\.lua\\'" . lua-mode))

;; Haskell (xmonad konfigurace)
(use-package haskell-mode
  :mode ("\\.hs\\'" . haskell-mode))

;; YAML
(use-package yaml-mode
  :mode ("\\.ya?ml\\'" . yaml-mode))

;; Markdown
(use-package markdown-mode
  :mode (("\\.md\\'"       . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

;; Java a C/C++
;; - ensure nil: vestavene baliky
(use-package java-mode
  :ensure nil
  :mode ("\\.java\\'" . java-mode))

(use-package cc-mode
  :ensure nil
  :mode (("\\.c\\'"   . c-mode)
         ("\\.h\\'"   . c-mode)
         ("\\.cpp\\'" . c++-mode)
         ("\\.hpp\\'" . c++-mode)))

;; Shell skripty
;; - ensure nil: vestaveny balik
;; - pokryva bash, zsh a konfiguracni soubory bez pripony
(use-package sh-script
  :ensure nil
  :mode (("\\.sh\\'"   . sh-mode)
         ("\\.bash\\'" . sh-mode)
         ("\\.zsh\\'"  . sh-mode)
         ("bashrc$"    . sh-mode)
         ("zshrc$"     . sh-mode)))

;; JSON (Emacs 29+ tree-sitter)
;; - ensure nil: vestaveny balik
(use-package json-ts-mode
  :ensure nil
  :if (>= emacs-major-version 29)
  :mode ("\\.json\\'" . json-ts-mode))

;; CSS a JavaScript
;; - ensure nil: vestavene baliky
;; - odsazeni 2 mezery (web standard)
(use-package css-mode
  :ensure nil
  :mode ("\\.css\\'" . css-mode)
  :config
  (setq css-indent-offset 2))

(use-package js
  :ensure nil
  :mode ("\\.js\\'" . js-mode)
  :config
  (setq js-indent-level 2))

;; Vimrc, HTML a Emmet
;; - emmet: Tab rozepise zkratky do plneho HTML
(use-package vimrc-mode
  :mode ("\\.vimrc\\'" "\\.vim\\'" "vimrc$"))

(use-package web-mode
  :mode (("\\.html\\'" . web-mode)
         ("\\.htm\\'"  . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset    2
        web-mode-code-indent-offset   2))

(use-package emmet-mode
  :hook (web-mode . emmet-mode)
  :config
  (setq emmet-expand-jsx-className? nil)
  :bind (:map emmet-mode-keymap
              ("<tab>" . emmet-expand-line)))

(provide 'salix-languages)

;;; salix-languages.el ends here
