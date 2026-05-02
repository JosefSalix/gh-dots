;;; salix-backups.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi zalohovani a autosave souboru.
;; Vsechny zalohy a autosave soubory se ukladaji do var/ aby nezanesly projekt.
;; Vypina lockfiles ktere jsou ve vetsine pripadu zbytecne.

;;; Code:

;; Definice slozek pro zalohy a autosave
;; - oboje se uklada do var/ oddelene od konfigurace
(defvar salix-backup-dir
  (expand-file-name "var/backups/" user-emacs-directory)
  "Directory for backup files.")

(defvar salix-autosave-dir
  (expand-file-name "var/autosave/" user-emacs-directory)
  "Directory for autosave files.")

;; Vytvoreni slozek pokud neexistuji
(dolist (dir (list salix-backup-dir salix-autosave-dir))
  (unless (file-directory-p dir)
    (make-directory dir t)))

;; Presmerovani zaloh na jedno misto
;; - vsechny zalohy se ukladaji do var/backups/
(setq backup-directory-alist
      `(("." . ,salix-backup-dir)))

;; Zalohovani kopirovanim
;; - original zustane na miste, zalohа se vytvori jako novy soubor
(setq backup-by-copying t)

;; Verzovani zaloh
;; - emacs udrzi 6 novejsich a 2 starsi verze
;; - stare verze se automaticky mazou
(setq version-control t)
(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 2)

;; Nastaveni autosave
;; - autosave soubory se ukladaji do var/autosave/
;; - uklada se po 200 znacich nebo 20 sekundach necinnosti
(setq auto-save-default t)
(setq auto-save-file-name-transforms
      `((".*" ,salix-autosave-dir t)))
(setq auto-save-interval 200)
(setq auto-save-timeout 20)

;; Vypnuti lockfiles
;; - soubory .# jsou ve vetsine pripadu zbytecne
(setq create-lockfiles nil)

(provide 'salix-backups)

;;; salix-backups.el ends here
