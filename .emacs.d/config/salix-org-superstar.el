;;; salix-org-superstar.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi org-superstar - pekne symboly pro nadpisy a seznamy.
;; Kazda uroven nadpisu ma vlastni symbol, seznamy take.

;;; Code:

;; Org-superstar - symboly pro nadpisy a seznamy
;; - 8 urovni nadpisu, kazda ma vlastni symbol
;; - +/*/-  nahrazeny hezkcimi symboly v seznamech
;; - leading-bullet: mezera misto viditelnych hvezdicek
(use-package org-superstar
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-headline-bullets-list
        '("⌬" "◉" "⌾" "○" "✤" "✜" "◆" "▶")
        org-superstar-item-bullet-alist
        '((?+ . ?⦁)
          (?* . ?➝)
          (?- . ?➤))
        org-superstar-leading-bullet ?\s
        org-superstar-special-todo-items t))

(provide 'salix-org-superstar)

;;; salix-org-superstar.el ends here
