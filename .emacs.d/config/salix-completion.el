;;; salix-completion.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi moderni completion framework.
;; Vertico zajistuje UI minibufferu, orderless flexibilni filtrovani
;; a marginalia zobrazuje doplnkove informace u kandidatu.

;;; Code:

;; Vertico - UI pro minibuffer (M-x, find-file, prepinani bufferu)
;; - demand t: nacte se hned, minibuffer musi byt pripraveny od zacatku
;; - cycle: konec seznamu => zacatek
;; - resize nil: minibuffer neskace pri ruznem poctu kandidatu
(use-package vertico
  :demand t
  :init
  (vertico-mode 1)
  :config
  (setq vertico-cycle t)
  (setq vertico-resize nil)
  (setq vertico-count 10))

;; Orderless - flexibilni filtrovani kandidatu
;; - mezera rozdeli dotaz na vice nezavislych podminek
;; - pro soubory se pouziva klasicky styl (presnejsi pro cesty)
(use-package orderless
  :demand t
  :init
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides
        '((file (styles partial-completion))))
  :config
  (setq orderless-component-separator
        #'orderless-escapable-split-on-space))

;; Marginalia - doplnkove informace u kandidatu v minibufferu
;; - zobrazuje napr. klavesove zkratky u prikazu, velikost u souboru
(use-package marginalia
  :demand t
  :init
  (marginalia-mode 1)
  :config
  (setq marginalia-align 'right))

(provide 'salix-completion)

;;; salix-completion.el ends here
