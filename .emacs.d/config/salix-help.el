;;; salix-help.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nahrazuje vychozi help prikazy za helpful - lepsi formatovani a vice informaci.
;; Embark pridava kontextove akce pro prvky v minibufferu.

;;; Code:

;; Helpful - lepsi help buffery
;; - remap nahrazuje vychozi describe-* prikazy bez zmeny klavesovych zkratek
(use-package helpful
  :defer t
  :init
  (global-set-key [remap describe-function] #'helpful-callable)
  (global-set-key [remap describe-command]  #'helpful-command)
  (global-set-key [remap describe-variable] #'helpful-variable)
  (global-set-key [remap describe-key]      #'helpful-key))

;; Embark - kontextove akce (jako prave tlacitko mysi pro klavesnici)
;; - C-. zobrazi menu akci, C-; spusti nejpravdepodobnejsi akci
(use-package embark
  :defer t
  :init
  (global-set-key (kbd "C-.") #'embark-act)
  (global-set-key (kbd "C-;") #'embark-dwim)
  (global-set-key (kbd "C-h B") #'embark-bindings))

;; Embark-consult - propojeni embark a consult
;; - pridava nahled pri prochazeni seznamu vysledku
(use-package embark-consult
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(provide 'salix-help)

;;; salix-help.el ends here
