;;; salix-vc.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi nastroje pro spravu verzi (Git).
;; Magit poskytuje plnohodnotne Git UI, diff-hl zobrazuje zmeny ve fringi.

;;; Code:

;; Magit - Git UI pro Emacs
;; - otevre status ve stejnem okne (krome diffu)
;; - automaticka obnova po ulozeni souboru
(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  :config
  (add-hook 'after-save-hook #'magit-after-save-refresh-status t))

;; Git-timemachine - prochazeni historie souboru
;; - p/n: pohyb mezi commity
(use-package git-timemachine
  :commands git-timemachine)

;; Diff-hl - zobrazeni zmen oproti poslednimu commitu ve fringi
;; - flydiff: aktualizace bez nutnosti ulozeni
;; - obnova po operacich v magitu
(use-package diff-hl
  :config
  (global-diff-hl-mode 1)
  (diff-hl-flydiff-mode 1)
  (with-eval-after-load 'magit
    (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh)))

(provide 'salix-vc)

;;; salix-vc.el ends here
