;;; salix-fonts.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi fonty pro cely Emacs.
;; Pouziva jeden monospace font vsude s moznosti oddelit velikost
;; pro fixed-pitch (org bloky, tabulky) a variable-pitch (text, nadpisy).

;;; Code:

;; Definice fontu a velikosti
;; - font-size: UI a variable-pitch
;; - fixed-pitch-size: org bloky a tabulky (mensi)
(defvar salix/font-family "CaskaydiaCove Nerd Font"
  "Font family used throughout Emacs.")

(defvar salix/font-size 150
  "Default font size for UI and variable-pitch faces (in 1/10 pt).")

(defvar salix/fixed-pitch-size 140
  "Font size for fixed-pitch faces like Org blocks and tables (in 1/10 pt).")

;; Pomocna funkce pro overeni existence fontu
(defun salix/font-installed-p (font-name)
  "Return non-nil if FONT-NAME is available on this system."
  (find-font (font-spec :name font-name)))

;; Nastaveni fontu pro vsechny faces
(cond
 ((salix/font-installed-p salix/font-family)
  ;; default face - cely UI
  (set-face-attribute 'default nil
                      :family salix/font-family
                      :height salix/font-size)
  ;; fixed-pitch - org bloky, tabulky, kod
  (set-face-attribute 'fixed-pitch nil
                      :family salix/font-family
                      :height salix/fixed-pitch-size)
  ;; variable-pitch - text, nadpisy v org
  (set-face-attribute 'variable-pitch nil
                      :family salix/font-family
                      :height salix/font-size)
  ;; emoji fallback
  (when (salix/font-installed-p "Noto Color Emoji")
    (set-fontset-font t 'emoji (font-spec :family "Noto Color Emoji"))))
 (t
  (message "Warning: Font '%s' not installed!" salix/font-family)))

(provide 'salix-fonts)

;;; salix-fonts.el ends here
