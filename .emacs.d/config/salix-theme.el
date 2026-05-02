;;; salix-theme.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi barevne tema a vzhled mode-line.
;; Podporuje prepinani mezi dark a light tematem.
;; Telephone-line zajistuje hezci mode-line bez tezke zavislosti.

;;; Code:

;; Definice temat pro dark a light mode
(defvar salix/current-theme nil
  "Currently active theme: 'dark or 'light.")

(defvar salix/dark-theme 'doom-tomorrow-night
  "Theme used for dark mode.")

(defvar salix/light-theme 'doom-tomorrow-day
  "Theme used for light mode.")

;; Pomocne funkce pro prepinani temat
;; - disable-all-themes zajisti ze se temata nevrstvi
;; - fix-line-number-background opravi pozadi cisel radku po nacteni tematu
(defun salix/disable-all-themes ()
  "Disable all currently enabled themes."
  (mapc #'disable-theme custom-enabled-themes))

(defun salix/fix-line-number-background ()
  "Set line-number background to match default background."
  (set-face-attribute 'line-number nil
                      :background (face-attribute 'default :background)))

(defun salix/load-theme (theme)
  "Disable current themes and load THEME."
  (salix/disable-all-themes)
  (load-theme theme t)
  (salix/fix-line-number-background))

;; Funkce pro nastaveni a prepinani temat
;; - toggle pouziva memq pro spolehlivejsi detekci aktivniho tematu
(defun salix/set-dark-theme ()
  "Enable the dark theme."
  (interactive)
  (salix/load-theme salix/dark-theme)
  (setq salix/current-theme 'dark)
  (message "Loaded dark theme: %s" salix/dark-theme))

(defun salix/set-light-theme ()
  "Enable the light theme."
  (interactive)
  (salix/load-theme salix/light-theme)
  (setq salix/current-theme 'light)
  (message "Loaded light theme: %s" salix/light-theme))

(defun salix/toggle-theme ()
  "Toggle between dark and light theme."
  (interactive)
  (if (memq salix/light-theme custom-enabled-themes)
      (salix/set-dark-theme)
    (salix/set-light-theme)))

;; Balicky temat
;; - doom-themes: demand t kvuli light tematu a org konfiguraci
(use-package kanagawa-themes
  :defer t)

(use-package doom-themes
  :demand t
  :config
  (ignore-errors (doom-themes-org-config))
  (salix/set-dark-theme))

;; Nerd-icons - podpora ikon (pouze v grafickem rezimu)
;; - pokud chybi fonty, zobrazi tip jak je nainstalovat
(use-package nerd-icons
  :if (display-graphic-p)
  :defer t
  :config
  (unless (find-font (font-spec :name "Symbols Nerd Font Mono"))
    (message "Tip: run M-x nerd-icons-install-fonts")))

;; Telephone-line - hezci mode-line
(use-package telephone-line
  :demand t
  :config
  (telephone-line-mode 1))

(provide 'salix-theme)

;;; salix-theme.el ends here
