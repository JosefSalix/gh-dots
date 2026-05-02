;;; salix-org-ui.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi vzhled Org mode - fonty, velikosti a barvy nadpisu.
;; Vychozi stav pouziva barvy tematu, zkratka t o zapne vlastni paletu.
;; Palety: gruvbox, onedark, catppuccin, tokyonight, rosepine.

;;; Code:

;; Stavove promenne pro nadpisy
;; - custom-colors-enabled: nil = barvy tematu, t = vlastni paleta
;; - color-variant: vybrana kombinace barev (1-20)
(require 'cl-lib)

(defvar salix/org-heading-font "Goldman"
  "Font family used for Org headings.")

(defvar salix/org-custom-colors-enabled nil
  "Non-nil if custom heading colors are active.")

(defvar salix/org-color-variant 18
  "Selected heading color variant (1-20).")

;; Barevne kombinace pro nadpisy (20 variant po 4 barvach)
;; - gruvbox (1-4), onedark (5-8), catppuccin (9-12)
;; - tokyonight (13-16), rosepine (17-20)
(defvar salix/org-level-color-variants
  '(;; Gruvbox
    "#fb4934" "#fabd2f" "#83a598" "#d3869b"
    "#fe8019" "#8ec07c" "#fb4934" "#83a598"
    "#8ec07c" "#fb4934" "#d3869b" "#b8bb26"
    "#fb4934" "#d3869b" "#8ec07c" "#fabd2f"
    ;; Onedark
    "#e06c75" "#e5c07b" "#98c379" "#61afef"
    "#c678dd" "#56b6c2" "#e06c75" "#98c379"
    "#61afef" "#c678dd" "#e5c07b" "#56b6c2"
    "#98c379" "#e06c75" "#61afef" "#c678dd"
    ;; Catppuccin
    "#f38ba8" "#fab387" "#a6e3a1" "#89b4fa"
    "#cba6f7" "#89dceb" "#f38ba8" "#a6e3a1"
    "#89b4fa" "#cba6f7" "#fab387" "#89dceb"
    "#a6e3a1" "#f38ba8" "#89b4fa" "#cba6f7"
    ;; Tokyonight
    "#f7768e" "#e0af68" "#9ece6a" "#7aa2f7"
    "#bb9af7" "#7dcfff" "#f7768e" "#9ece6a"
    "#7aa2f7" "#bb9af7" "#e0af68" "#7dcfff"
    "#9ece6a" "#f7768e" "#7aa2f7" "#bb9af7"
    ;; Rosepine
    "#eb6f92" "#f6c177" "#31748f" "#9ccfd8"
    "#c4a7e7" "#ebbcba" "#eb6f92" "#31748f"
    "#31748f" "#c4a7e7" "#f6c177" "#ebbcba"
    "#9ccfd8" "#eb6f92" "#31748f" "#c4a7e7")
  "Color combinations for Org headings. Each group of 4 is one variant.")

;; Interaktivni prepinani vlastnich barev nadpisu
;; - t o: zapne vyber varianty, nebo vypne vlastni barvy
(defun salix/org-apply-colors-by-choice ()
  "Interactively choose a heading color variant or toggle custom colors off."
  (interactive)
  (if salix/org-custom-colors-enabled
      (progn
        (setq salix/org-custom-colors-enabled nil)
        (salix/org-font-setup)
        (message "Org heading colors: theme default"))
    (let* ((max (/ (length salix/org-level-color-variants) 4))
           (choice (read-number (format "Variant (1-%d): " max)
                                salix/org-color-variant)))
      (when (and (>= choice 1) (<= choice max))
        (setq salix/org-color-variant choice
              salix/org-custom-colors-enabled t)
        (salix/org-font-setup)
        (message "Org heading color variant: %d" choice)))))

;; Nastaveni fontu, velikosti a barev nadpisu
;; - goldman font pro nadpisy s fallbackem
;; - barvy tematu nebo vlastni paleta podle salix/org-custom-colors-enabled
;; - pruhledne pozadi pro org-block, org-code a org-verbatim
(defun salix/org-font-setup ()
  "Configure fonts, sizes and colors for Org headings."
  (let ((heading-font (if (find-font (font-spec :name salix/org-heading-font))
                          salix/org-heading-font
                        (face-attribute 'default :family))))
    ;; - velikosti a font nadpisu
    (dolist (face '((org-level-1 . 1.50)
                    (org-level-2 . 1.40)
                    (org-level-3 . 1.30)
                    (org-level-4 . 1.20)
                    (org-level-5 . 1.05)
                    (org-level-6 . 1.05)
                    (org-level-7 . 1.05)
                    (org-level-8 . 1.05)))
      (set-face-attribute (car face) nil
                          :font heading-font
                          :weight 'bold
                          :height (cdr face)))
    ;; - barvy nadpisu
    (if salix/org-custom-colors-enabled
        (let* ((start (* 4 (1- salix/org-color-variant)))
               (colors (cl-subseq salix/org-level-color-variants start (+ start 4))))
          (set-face-attribute 'org-level-1 nil :foreground (nth 0 colors))
          (set-face-attribute 'org-level-2 nil :foreground (nth 1 colors))
          (set-face-attribute 'org-level-3 nil :foreground (nth 2 colors))
          (set-face-attribute 'org-level-4 nil :foreground (nth 3 colors)))
      (set-face-attribute 'org-level-1 nil :foreground 'unspecified)
      (set-face-attribute 'org-level-2 nil :foreground 'unspecified)
      (set-face-attribute 'org-level-3 nil :foreground 'unspecified)
      (set-face-attribute 'org-level-4 nil :foreground 'unspecified))
    ;; - monospace pro kod a tabulky
    (dolist (face '(org-block org-table org-formula
                    org-code org-verbatim
                    org-special-keyword org-meta-line org-checkbox))
      (set-face-attribute face nil :inherit 'fixed-pitch))
    ;; - pruhledne pozadi a bez zvyrazneni
    (set-face-attribute 'org-block nil :background "transparent")
    (set-face-attribute 'org-code nil :inherit 'fixed-pitch :background "transparent")
    (set-face-attribute 'org-verbatim nil :inherit 'fixed-pitch :background "transparent")
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))))

;; Aplikace nastaveni po nacteni org a pri otevreni souboru
;; - advice zajisti obnovu po prepnuti tematu
(with-eval-after-load 'org
  (salix/org-font-setup))

(add-hook 'org-mode-hook #'salix/org-font-setup)

(advice-add 'load-theme :after
            (lambda (&rest _)
              (salix/org-font-setup)))

(provide 'salix-org-ui)

;;; salix-org-ui.el ends here
