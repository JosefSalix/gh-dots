;;; salix-packages.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi repozitare balicku a jejich priority.
;; Inicializuje use-package pro spravu balicku.
;; Refresuje archivy jen jednou za 7 dni aby nezpomaloval start.

;;; Code:

;; Nacteni vestaveneho balickoveho systemu emacsu
(require 'package)

;; Povolit aktualizaci vestavenych balicku
;; - use-package muze aktualizovat i balicky ktere jsou soucasti emacsu
(setq package-install-upgrade-built-in t)

;; Nastaveni repozitaru balicku
;; - gnu a nongnu jsou oficialni a stabilni
;; - melpa je nejvetsi ale muze byt mene stabilni
(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))

;; Nastaveni priorit repozitaru
;; - pokud balicek existuje ve vice repozitarich vezme se z toho s vyssi prioritou
(setq package-archive-priorities
      '(("gnu"    . 10)
        ("nongnu" . 5)
        ("melpa"  . 0)))

;; Inicializace balickoveho systemu
;; - kontrola zajisti ze se neinicializuje dvakrat
(unless (bound-and-true-p package--initialized)
  (package-initialize))

;; Definice intervalu a souboru pro refresh archivu
;; - interval je nastaven na 7 dni
;; - cas posledniho refreshe se uklada do timestamp souboru
(defvar salix/package-refresh-interval (* 7 24 60 60)
  "How often (in seconds) to refresh package archives.")

(defvar salix/package-refresh-file
  (expand-file-name "package-refresh.timestamp" user-emacs-directory)
  "File storing the last time package archives were refreshed.")

;; Funkce ktera overi zda je potreba obnovit archivy
;; - porovna aktualni cas s casem posledniho refreshe
(defun salix/package-refresh-needed-p ()
  "Return non-nil if package archives should be refreshed."
  (let* ((now (float-time))
         (last (if (file-exists-p salix/package-refresh-file)
                   (with-temp-buffer
                     (insert-file-contents salix/package-refresh-file)
                     (string-to-number (buffer-string)))
                 0)))
    (> (- now last) salix/package-refresh-interval)))

;; Funkce ktera obnovi archivy pokud je to potreba
;; - po refreshi ulozi aktualni cas do timestamp souboru
(defun salix/package-refresh-maybe ()
  "Refresh package archives if enough time has passed."
  (when (salix/package-refresh-needed-p)
    (message "Refreshing package archives...")
    (package-refresh-contents)
    (with-temp-file salix/package-refresh-file
      (insert (number-to-string (float-time))))))

;; Obnoveni archivu pokud je seznam balicku prazdny
;; - pri prvnim spusteni se archivy vzdy stahnou
(unless package-archive-contents
  (salix/package-refresh-maybe))

;; Instalace a nacteni use-package
;; - pokud neni nainstalovan, automaticky se stahne
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

;; Nastaveni use-package
;; - always-ensure: balicky se automaticky stahnou pokud chybi
;; - always-defer: balicky se nacitaji az kdyz jsou potreba => rychly start
;; - expand-minimally: use-package generuje mene kodu => rychlejsi nacitani
(setq use-package-always-ensure t
      use-package-always-defer t
      use-package-verbose nil
      use-package-expand-minimally t)

(provide 'salix-packages)

;;; salix-packages.el ends here
