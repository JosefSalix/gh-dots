;;; salix-line-numbers.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi zobrazovani cisel radku.
;; Relativni cisla usnadnuji pohyb pomoci vim-like prikazu.

;;; Code:

;; Relativni cisla radku s absolutnim cislem na aktualnim radku
(setq display-line-numbers-type 'relative)

(when (boundp 'display-line-numbers-current-absolute)
  (setq display-line-numbers-current-absolute t))

;; Seznam bufferu kde se cisla radku nezobrazuji
(defvar salix/no-line-numbers-buffers
  '("*scratch*" "*Messages*" "*dashboard*")
  "List of buffer names where line numbers should be disabled.")

;; Funkce pro vypnuti cisel radku ve specifickych bufferech
(defun salix/maybe-disable-line-numbers ()
  "Disable line numbers in specific named buffers."
  (when (member (buffer-name) salix/no-line-numbers-buffers)
    (display-line-numbers-mode -1)))

;; Zapnuti cisel radku v programovacich modech
;; - special-mode-hook: vypnuti v help, messages a podobnych bufferech
;; - after-change-major-mode-hook: vypnuti v bufferech ze seznamu
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'special-mode-hook (lambda () (display-line-numbers-mode -1)))
(add-hook 'after-change-major-mode-hook #'salix/maybe-disable-line-numbers)

(provide 'salix-line-numbers)

;;; salix-line-numbers.el ends here
