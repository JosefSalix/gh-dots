;;; init.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nacita se jako druhy hned po early-init.el.
;; Uklizi nastaveni customize do oddeleneho souboru custom.el,
;; nacita ostatni moduly konfigurace a vraci GC na normalni hodnoty.

;;; Code:

;; Presmerovani customize nastaveni do oddeleneho souboru
;; - jinak by emacs psal automaticky generovany kod primo do init.el
(setq custom-file (expand-file-name "config/custom.el" user-emacs-directory))

;; Vytvoreni slozky config/ pokud neexistuje
;; - sem patri custom.el a ostatni konfiguracni soubory
(let ((config-dir (expand-file-name "config" user-emacs-directory)))
  (unless (file-directory-p config-dir)
    (make-directory config-dir t)))

;; Vytvoreni custom.el pokud neexistuje
;; - vytvori se s hlavickou lexical-binding
(unless (file-exists-p custom-file)
  (with-temp-buffer
    (insert ";;; custom.el -*- lexical-binding: t; -*-\n\n")
    (write-file custom-file)))

;; Nacteni custom.el
;; - noerror zajisti ze emacs nespadne pokud soubor neexistuje
(load custom-file 'noerror)

;; Potlaceni zprav behem startu
;; - po startu se zpravy automaticky zapnou
(setq inhibit-message t)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq inhibit-message nil)))

;; Pridani config/ do load-path
;; - jinak by emacs nenasеl moduly pri require
(add-to-list 'load-path (expand-file-name "config" user-emacs-directory))

;; Nacteni modulu konfigurace
;; - salix-packages musi byt prvni (inicializuje use-package)
(require 'salix-packages)
(require 'salix-backups)
(require 'salix-completion)
(require 'salix-search)
(require 'salix-help)
(require 'salix-fonts)
(require 'salix-line-numbers)
(require 'salix-transparency)
(require 'salix-ui)
(require 'salix-theme)
(require 'salix-keybindings)
(require 'salix-tools)
(require 'salix-dired)
(require 'salix-vc)
(require 'salix-languages)
(require 'salix-markdown)
(require 'salix-csv)
(require 'salix-terminals)
(require 'salix-org-core)
(require 'salix-org-ui)
(require 'salix-org-superstar)
(require 'salix-org-babel)
(require 'salix-org-templates)
(require 'salix-org-tasks)

;; Reset GC po startu a zobrazeni casu startu
;; - gc-cons-threshold se vraci na beznou hodnotu 16 MB
;; - cas se zobrazi s malym zpozdenim kvuli inhibit-message
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024))
            (setq gc-cons-percentage 0.1)
            (run-at-time
             0.2 nil
             (lambda ()
               (message "Emacs loaded in %.2f seconds"
                        (float-time (time-subtract after-init-time before-init-time)))))))

;;; init.el ends here
