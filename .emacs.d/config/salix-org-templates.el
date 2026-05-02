;;; salix-org-templates.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi org-tempo sablony pro rychle vlozeni bloku.
;; Zkratka: napsat "<py" a stisknout Tab vlozi python src blok.
;; Obsahuje i vlastni SQL varianty pro postgres, sqlite a mysql.

;;; Code:

;; Org-tempo sablony pro src bloky
;; - <xy Tab vlozi src blok daneho jazyka
;; - SQL varianty: <psql, <sqlite, <mysql + Tab
(with-eval-after-load 'org
  (require 'org-tempo)
  (dolist (template '(("sh"   . "src shell")
                      ("el"   . "src emacs-lisp")
                      ("py"   . "src python")
                      ("cc"   . "src C")
                      ("go"   . "src go")
                      ("lu"   . "src lua")
                      ("hs"   . "src haskell")
                      ("js"   . "src js")
                      ("css"  . "src css")
                      ("sql"  . "src sql")
                      ("yaml" . "src yaml")
                      ("json" . "src json")
                      ("md"   . "src markdown")
                      ("conf" . "src conf-unix")
                      ("ta"   . "src table")))
    (unless (assoc (car template) org-structure-template-alist)
      (add-to-list 'org-structure-template-alist template)))
  (defun salix-org-tempo-add-tag (key begin end)
    "Add a custom tempo tag with specific block content."
    (tempo-define-template
     (concat "org-" key)
     `(,(concat "#+begin_" begin "\n")
       p "\n"
       ,(concat "#+end_" end))
     (concat "<" key)
     (concat "Org " key " block")
     'org-tempo-tags))
  (dolist (db '(("psql"   . "src sql :results output :engine postgres")
                ("sqlite" . "src sql :results output :engine sqlite")
                ("mysql"  . "src sql :results output :engine mysql")))
    (salix-org-tempo-add-tag (car db) (cdr db) "src")))

(provide 'salix-org-templates)

;;; salix-org-templates.el ends here
