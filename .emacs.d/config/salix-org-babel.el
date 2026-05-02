;;; salix-org-babel.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi Org Babel - spousteni kodu v org souborech.
;; Povoli vybrane jazyky a nastavi mapovani na major mody.

;;; Code:

;; Org Babel - spousteni kodu v org souborech
;; - ob-go: podpora Go (neni vestavenych)
;; - confirm-babel-evaluate nil: bez potvrzeni pred spustenim
;; - fontify-natively: zvyrazneni kodu v blocich
(use-package ob-go
  :defer t
  :after org)

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell      . t)
     (go         . t)
     (C          . t)
     (sql        . t)
     (python     . t)))
  (setq org-babel-python-command "python3")
  (setq org-confirm-babel-evaluate nil)
  (setq org-src-fontify-natively t
        org-src-window-setup 'current-window))

;; Mapovani nazvu jazyku na major mody pro zvyrazneni
;; - napr. javascript => js-mode, vim => vimrc-mode
(with-eval-after-load 'org-src
  (dolist (lang-mode '(("conf-unix"  . conf-unix)
                       ("markdown"   . markdown)
                       ("haskell"    . haskell)
                       ("lua"        . lua)
                       ("css"        . css)
                       ("javascript" . js)
                       ("json"       . json)
                       ("yaml"       . yaml)
                       ("go"         . go)
                       ("vim"        . vimrc)
                       ("sql"        . sql)))
    (push lang-mode org-src-lang-modes)))

(provide 'salix-org-babel)

;;; salix-org-babel.el ends here
