;;; early-init.el -*- lexical-binding: t; -*-

;;; Commentary:

;; Tento soubor emacs hleda automaticky, neni potreba ho nikde nacitat.
;; Spousti se jako uplne prvni - jeste pred inicializaci balicku
;; a grafickeho rozhrani. Proto sem patri veci jako vypnuti UI
;; a nastaveni GC, aby se projevily co nejdrive.

;;; Code:

;; Zvyseni limitu GC pri startu
;; - emacs uklizi pamet mene casto => rychlejsi start
;; - hodnoty se resetuji na rozumnejsi v init.el
(setq gc-cons-threshold (* 256 1024 1024))
(setq gc-cons-percentage 0.6)

;; Vypnuti hlasek nativni kompilace
;; - emacs muze na pozadi vypisovat varovani a chyby
;; - pri startu by to mohlo rusit
(setq native-comp-async-report-warnings-errors nil)

;; Vypnuti automaticke inicializace balicku pri startu
;; - rucne rizeno v init.el pres use-package
;; - jinak by emacs inicializoval balicky dvakrat => pomalejsi start
(setq package-enable-at-startup nil)

;; Ponechat font cache v pameti
;; - emacs by ji jinak prubezne uvolnoval a znovu nacital
;; - rychlejsi UI hlavne pri pouziti ikon (nerd-fonts)
(setq inhibit-compacting-font-caches t)

;; Vypnuti zbytecnych UI prvku pri startu
;; - menu-bar, tool-bar, scroll-bar a tooltip nepotrebujes
;; - fboundp overi ze funkce existuje => bezpecne i v terminalu
(when (fboundp 'menu-bar-mode)   (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)   (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'tooltip-mode)    (tooltip-mode -1))

;; Zamezeni automaticke zmene velikosti okna pri startu
(setq frame-inhibit-implied-resize t)

;;; early-init.el ends here
