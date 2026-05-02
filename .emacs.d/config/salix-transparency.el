;;; salix-transparency.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi pruhlednost okna Emacsu.
;; Umoznuje menit pruhlednost interaktivne nebo ji prepnout jednim prikazem.

;;; Code:

;; Vychozi pruhlednost okna (aktivni . neaktivni)
;; - 100 = plne nepruhledne, 0 = plne pruhledne
(defvar salix/frame-transparency '(99 . 90)
  "Frame transparency in the form (active . inactive).
Values range 0-100, where 100 is fully opaque and 0 is fully transparent.")

;; Funkce pro nastaveni pruhlednosti (M-x salix/set-transparency)
;; - overi ze jsme v grafickem rezimu a ze je hodnota 0-100
;; - nastavi pruhlednost pro aktualni i budouci okna
(defun salix/set-transparency (alpha)
  "Set frame transparency to ALPHA (0-100).
Applies to both active and inactive states."
  (interactive "nEnter opacity percent (0-100): ")
  (cond
   ((not (display-graphic-p))
    (message "Transparency is only available in graphical mode."))
   ((or (< alpha 0) (> alpha 100))
    (message "Error: value must be between 0 and 100!"))
   (t
    (let ((alpha-pair `(,alpha . ,alpha)))
      (set-frame-parameter nil 'alpha alpha-pair)
      (set-frame-parameter nil 'alpha-background alpha)
      (setf (alist-get 'alpha default-frame-alist) alpha-pair)
      (setf (alist-get 'alpha-background default-frame-alist) alpha)
      (message "Frame opacity set to %d%%" alpha)))))

;; Funkce pro prepinani pruhlednosti (M-x salix/toggle-transparency)
;; - prepina mezi plne nepruhlednym a vychozi pruhlednosti
(defun salix/toggle-transparency ()
  "Toggle between transparent and opaque frame."
  (interactive)
  (let ((current-alpha (or (frame-parameter nil 'alpha) '(100 . 100))))
    (if (equal current-alpha '(100 . 100))
        (salix/set-transparency (car salix/frame-transparency))
      (salix/set-transparency 100))))

;; Aplikace pruhlednosti pri startu
;; - pouze v grafickem rezimu
;; - alpha-background pro novejsi verze emacsu
(when (display-graphic-p)
  (set-frame-parameter nil 'alpha salix/frame-transparency)
  (add-to-list 'default-frame-alist `(alpha . ,salix/frame-transparency))
  (add-to-list 'default-frame-alist `(alpha-background . ,(car salix/frame-transparency))))

(provide 'salix-transparency)

;;; salix-transparency.el ends here
