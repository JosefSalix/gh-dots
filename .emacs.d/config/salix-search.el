;;; salix-search.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi vyhledavani v Emacsu.
;; Consult rozsiruje zakladni prikazy o moderni UI.
;; Isearch se upravi pro pohodlnejsi pouzivani.

;;; Code:

;; Consult - rozsirene vyhledavani a navigace
;; - narrow-key: stiskni < pro zuzeni vysledku podle kategorie
(use-package consult
  :defer t
  :init
  (setq consult-narrow-key "<"))

;; Isearch - zobrazeni poctu vysledku
;; - format: (aktualni/celkem) pred hledanym vyrazem
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "(%s/%s) ")

;; Povoleni pohybu kurzoru behem hledani
(setq isearch-allow-motion t)

;; Mezera v hledanem vyrazu odpovida libovolnym znakum
(setq search-whitespace-regexp ".*?")

;; Hledani ignoruje velikost pismen
(setq case-fold-search t)

;; Zvyrazneni vsech vyskytu hledaneho vyrazu v bufferu
(setq isearch-lazy-highlight t)

;; Hledani bere v uvahu varianty znaku
;; - napr. "e" najde i "e" s diakritikou
(setq search-default-mode #'char-fold-to-regexp)

(provide 'salix-search)

;;; salix-search.el ends here
