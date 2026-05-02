;;; salix-terminals.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi vterm - plnohodnotny terminal emulator.
;; salix/open-vterm otevre vterm nebo prepne na existujici buffer.

;;; Code:

;; Vterm - plnohodnotny terminal emulator
;; - kill-buffer-on-exit: buffer se zavre po ukonceni shellu
;; - open-vterm: prepne na existujici buffer nebo otevre novy
(use-package vterm
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000
        vterm-kill-buffer-on-exit t
        vterm-always-compile-module t))

(defun salix/open-vterm ()
  "Open or switch to existing vterm buffer."
  (interactive)
  (if (get-buffer "*vterm*")
      (switch-to-buffer "*vterm*")
    (vterm)))

(provide 'salix-terminals)

;;; salix-terminals.el ends here
