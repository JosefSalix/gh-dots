;;; salix-dired.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi Dired - vestaveny spravce souboru.
;; Pridava vim-like navigaci, barveni, ikony a otevirani souboru externimi aplikacemi.

;;; Code:

;; Dired - vestaveny spravce souboru
;; - ensure nil: vestaveny balik
;; - h/l: vim-like navigace (nahoru/dolu v adresarich)
;; - dwim-target: pri kopirovani navrhne druhe otevrene okno jako cil
(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :custom
  (dired-listing-switches "-agho --group-directories-first")
  (dired-dwim-target t)
  (dired-kill-when-opening-new-dired-buffer t)
  :bind (:map dired-mode-map
              ("h" . dired-up-directory)
              ("l" . dired-find-file)
              ("o" . dired-open-file)))

;; Barveni a ikony v Dired
;; - nerd-icons-dired: pouze v grafickem rezimu
(use-package diredfl
  :hook (dired-mode . diredfl-mode))

(use-package nerd-icons-dired
  :if (display-graphic-p)
  :hook (dired-mode . nerd-icons-dired-mode))

;; Otevirani souboru externimi aplikacemi
;; - obrazky: feh, videa: mpv, pdf/epub: zathura, csv: libreoffice
(use-package dired-open
  :defer t
  :config
  (setq dired-open-extensions
        '(("png"  . "feh")
          ("jpg"  . "feh")
          ("jpeg" . "feh")
          ("gif"  . "feh")
          ("mkv"  . "mpv")
          ("mp4"  . "mpv")
          ("avi"  . "mpv")
          ("pdf"  . "zathura")
          ("epub" . "zathura")
          ("csv"  . "libreoffice"))))

;; Skryvani dotfiles v Dired
;; - H: prepnuti zobrazeni dotfiles
(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :bind (:map dired-mode-map
              ("H" . dired-hide-dotfiles-mode)))

;; Nahled souboru bez otevreni
;; - V: prepnuti nahledu
(use-package peep-dired
  :commands peep-dired
  :bind (:map dired-mode-map
              ("V" . peep-dired)))

(provide 'salix-dired)

;;; salix-dired.el ends here
