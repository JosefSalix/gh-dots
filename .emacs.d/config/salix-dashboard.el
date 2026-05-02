;;; salix-dashboard.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Vlastni uvodni stranka v scratch bufferu.
;; Zobrazuje ASCII logo, datum, emacs verze, pocet balicku a prehled klavesovych zkratek.

;;; Code:

(use-package dashboard
  :ensure t
  :demand t

  :config
  ;; 🖼️ logo
  (setq dashboard-startup-banner
        (expand-file-name "assets/salix-logo-v2.png" user-emacs-directory))

  ;; 🚫 žádný text pod logem
  (setq dashboard-banner-logo-title nil)

  ;; 🚫 úplně prázdný obsah
  (setq dashboard-items '())

  ;; 💬 jen footer (random quote)
  (setq dashboard-set-footer t)

  ;; 🎯 centrování
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content t)

  ;; 🚫 startup screen
  (setq inhibit-startup-screen t)
  (setq initial-scratch-message nil)

  ;; 🚀 zapnutí dashboardu
  (dashboard-setup-startup-hook))

(provide 'salix-dashboard)

;;; salix-dashboard.el ends here
