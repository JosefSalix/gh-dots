;;; salix-org-core.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Zakladni nastaveni Org mode - cesty, vzhled, logovani a export.
;; salix/org-mode-setup se spousti automaticky pri otevreni org souboru.

;;; Code:

;; Zakladni nastaveni pro Org buffery
;; - org-indent-mode: vizualni odsazeni pod nadpisy
;; - visual-line-mode: mekke zalamovani radku
;; - auto-fill-mode -1: vypnuti tvrdych zalamovani
(defun salix/org-mode-setup ()
  "Personal defaults for Org mode buffers."
  (org-indent-mode 1)
  (visual-line-mode 1)
  (auto-fill-mode -1))

;; Org - zakladni nastaveni
;; - ensure nil: vestaveny balik
(use-package org
  :ensure nil
  :hook (org-mode . salix/org-mode-setup)
  :config
  (setq org-directory (expand-file-name "~/org/")
        org-default-notes-file (expand-file-name "inbox.org" org-directory)
        ;; - folding a vzhled
        ;; -- content: zobrazuje nadpisy ale skryva obsah pri otevreni
        ;; -- hide-emphasis-markers: skryva znaky formatovani
        ;; -- pretty-entities: zobrazuje latex symboly jako unicode
        org-startup-folded 'content
        org-hide-leading-stars t
        org-ellipsis " ⮐"
        org-hide-emphasis-markers t
        org-pretty-entities t
        org-use-sub-superscripts '{}
        ;; -- logovani
        ;; -- log-done: cas dokonceni se ulozi pri oznaceni jako DONE
        ;; -- log-into-drawer: zaznamy jsou skryte v :LOGBOOK:
        org-log-done 'time
        org-log-into-drawer t
        ;; -- pohodli
        ;; -- return-follows-link: enter otevre odkaz
        org-mouse-1-follows-link t
        org-return-follows-link t
        org-cycle-separator-lines 1
        ;; -- prace se source blocky
        ;; -- tab funguje jako v danem jazyce
        ;; -- zachovani odsazeni pri exportu
        org-src-tab-acts-natively t
        org-src-preserve-indentation t
        org-edit-src-content-indentation 0
        ;; -- export
        ;; -- toc: obsah se prida pri exportu
        ;; -- bez cislovani sekci a validacniho odkazu v HTML
        org-export-with-toc t
        org-export-with-section-numbers nil
        org-html-validation-link nil))

(provide 'salix-org-core)

;;; salix-org-core.el ends here
