;;; salix-csv.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi CSV mode a barevne odliseni sloupcu.
;; Kazdy sloupec ma jinou barvu pro lepsi citelnost.

;;; Code:

;; CSV mode
;; - cl-lib: vestavenou knihovna pomocnych funkci
(require 'cl-lib)

(use-package csv-mode
  :mode ("\\.csv\\'" . csv-mode))

;; Barvy pro sloupce (Onedark paleta, cyklicky se opakuji)
(defvar salix/csv-column-colors
  '("#61afef" "#98c379" "#e5c07b" "#e06c75" "#c678dd" "#56b6c2")
  "Colors used for CSV column highlighting.")

;; Funkce pro barevne odliseni sloupcu
;; - prochazi radky a barveni sloupce podle indexu
;; - barvy se cyklicky opakuji
(defun salix/csv-colorize-region (start end)
  "Colorize CSV columns in region between START and END."
  (save-excursion
    (goto-char start)
    (while (< (point) end)
      (let ((line-end (line-end-position))
            (col-index 0))
        (while (< (point) line-end)
          (let ((col-start (point))
                (col-end (or (search-forward "," line-end t) line-end)))
            (add-face-text-property
             col-start (if (= col-end line-end) col-end (1- col-end))
             `(:foreground
               ,(nth (mod col-index (length salix/csv-column-colors))
                     salix/csv-column-colors))
             'append)
            (setq col-index (1+ col-index))
            (goto-char col-end))))
      (forward-line 1))))

;; Zapnuti barveni pri otevreni CSV souboru
;; - jit-lock: barveni jen viditelne casti, neblokuje emacs
(defun salix/csv-enable-coloring ()
  "Enable CSV column colorizing using jit-lock."
  (jit-lock-register #'salix/csv-colorize-region))

(add-hook 'csv-mode-hook #'salix/csv-enable-coloring)

(provide 'salix-csv)

;;; salix-csv.el ends here
