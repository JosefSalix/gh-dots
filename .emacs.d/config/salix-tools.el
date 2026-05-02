;;; salix-tools.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Uzitecne nastroje a vylepseni pro kazdodenni pouzivani.
;; Spravuje historii, pozice kurzoru a nedavne soubory.
;; Avy umoznuje rychlou navigaci po obrazovce.

;;; Code:

;; Recentf - seznam naposledy otevrenych souboru
;; - ensure nil: vestaveny balik, neni potreba stahovat
;; - exclude: vynechava elpa/, var/, tmp/ a ido soubory
(use-package recentf
  :ensure nil
  :init
  (setq recentf-save-file (expand-file-name "var/recentf" user-emacs-directory))
  (recentf-mode 1)
  :config
  (setq recentf-max-saved-items 50
        recentf-max-menu-items 15
        recentf-auto-cleanup 'never)
  (add-to-list 'recentf-exclude (expand-file-name "elpa/" user-emacs-directory))
  (add-to-list 'recentf-exclude (expand-file-name "var/" user-emacs-directory))
  (add-to-list 'recentf-exclude "/tmp/")
  (add-to-list 'recentf-exclude "\\.?ido\\.last$"))

;; Saveplace - zapamatovani pozice kurzoru v souborech
(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))

;; Savehist - ukladani historie minibufferu mezi sezenimi
;; - uklada i historii vyhledavani
;; - automaticke ukladani kazdych 60 sekund
(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode)
  :config
  (setq savehist-additional-variables '(search-ring regexp-search-ring)
        savehist-autosave-interval 60))

;; Avy - rychla navigace po obrazovce
;; - zkratka j j (salix-keybindings.el)
;; - avy-keys: pismena domaci rady klavesnice pro rychly vyber
(use-package avy
  :commands (avy-goto-char avy-goto-char-2 avy-goto-word-1 avy-goto-line)
  :config
  (setq avy-background t
        avy-style 'at-full
        avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
        avy-timeout-seconds 0.5))

(provide 'salix-tools)

;;; salix-tools.el ends here
