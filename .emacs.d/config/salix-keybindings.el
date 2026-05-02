;;; salix-keybindings.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Definuje leader key (M-.) a vsechny klavesove zkratky.
;; Which-key zobrazuje dostupne zkratky v popup okne.
;; Obsahuje i globalni zkratky mimo leader key.

;;; Code:

;; Which-key - zobrazeni dostupnych zkratek v popup okne
;; - popup se objevi po 0.3s necinnosti ve spodnim okne
(use-package which-key
  :demand t
  :config
  (setq which-key-idle-delay 0.3
        which-key-popup-type 'side-window
        which-key-side-window-location 'bottom
        which-key-sort-order 'which-key-key-order-alpha)
  (which-key-mode 1))

;; Leader key (M-.)
;; - M-. bylo puvodni xref-find-definitions, ale nepouzivas ho
(define-prefix-command 'salix/leader-map)
(global-set-key (kbd "M-.") 'salix/leader-map)

;; Tema a UI
;; - t d/l/t: vlastni funkce z salix-theme.el
;; - t p: vlastni funkce z salix-transparency.el
;; - t o: vlastni funkce z salix-org-ui.el (barvy nadpisu)
(define-key salix/leader-map (kbd "t d") #'salix/set-dark-theme)
(define-key salix/leader-map (kbd "t l") #'salix/set-light-theme)
(define-key salix/leader-map (kbd "t t") #'salix/toggle-theme)
(define-key salix/leader-map (kbd "t c") #'load-theme)
(define-key salix/leader-map (kbd "t p") #'salix/toggle-transparency)
(define-key salix/leader-map (kbd "t o") #'salix/org-apply-colors-by-choice)

;; Soubory
;; - f r: consult-recent-file (rozsireny recentf pres consult)
(define-key salix/leader-map (kbd "f f") #'find-file)
(define-key salix/leader-map (kbd "f s") #'save-buffer)
(define-key salix/leader-map (kbd "f d") #'dired-jump)
(define-key salix/leader-map (kbd "f r") #'consult-recent-file)

;; Buffery
;; - b b: consult-buffer (rozsireny switch-to-buffer pres consult)
(define-key salix/leader-map (kbd "b b") #'consult-buffer)
(define-key salix/leader-map (kbd "b k") #'kill-buffer)
(define-key salix/leader-map (kbd "b l") #'list-buffers)
(define-key salix/leader-map (kbd "b r") #'revert-buffer)

;; Emacs
(define-key salix/leader-map (kbd "q q") #'save-buffers-kill-terminal)

;; Okna
(define-key salix/leader-map (kbd "w v") #'split-window-right)
(define-key salix/leader-map (kbd "w h") #'split-window-below)
(define-key salix/leader-map (kbd "w d") #'delete-window)
(define-key salix/leader-map (kbd "w o") #'delete-other-windows)
(define-key salix/leader-map (kbd "w =") #'balance-windows)

;; Vyhledavani (consult)
;; - s s: hledani v bufferu
;; - s m: skok na symbol nebo nadpis
;; - s p: hledani v projektu (vyzaduje ripgrep)
;; - s f: hledani souboru v adresari
(define-key salix/leader-map (kbd "s s") #'consult-line)
(define-key salix/leader-map (kbd "s m") #'consult-imenu)
(define-key salix/leader-map (kbd "s p") #'consult-ripgrep)
(define-key salix/leader-map (kbd "s f") #'consult-find)

;; Kontextove akce (embark)
;; - .: zobrazi menu akci pro vec pod kurzorem
;; - ;: spusti nejpravdepodobnejsi akci primo
(define-key salix/leader-map (kbd ".") #'embark-act)
(define-key salix/leader-map (kbd ";") #'embark-dwim)

;; Napoveda (helpful - rozsireny help)
;; - nahrazuje vychozi describe-* prikazy
(define-key salix/leader-map (kbd "h f") #'helpful-callable)
(define-key salix/leader-map (kbd "h v") #'helpful-variable)
(define-key salix/leader-map (kbd "h k") #'helpful-key)
(define-key salix/leader-map (kbd "h c") #'helpful-command)

;; Org
;; - o d/w: vlastni agenda pohledy z salix-org-tasks.el
;; - o i/g: rychle otevreni inbox.org a agenda.org
;; - C-c o j: vlastni funkce z salix-org-core.el (otevreni denniho souboru)
;; - o r: obnovi agenda buffery
(define-key salix/leader-map (kbd "o a") #'org-agenda)
(define-key salix/leader-map (kbd "o c") #'org-capture)
(define-key salix/leader-map (kbd "o d")
            (lambda () (interactive) (org-agenda nil "d")))
(define-key salix/leader-map (kbd "o w")
            (lambda () (interactive) (org-agenda nil "w")))
(define-key salix/leader-map (kbd "o i")
            (lambda () (interactive) (find-file "~/org/inbox.org")))
(define-key salix/leader-map (kbd "o g")
            (lambda () (interactive) (find-file "~/org/daily.org")))
(global-set-key (kbd "C-c o j") #'salix/org-open-daily)
(define-key salix/leader-map (kbd "o r") #'org-agenda-redo)

;; Terminaly
;; - e e: eshell (vestaveny terminal emacs)
;; - e v: vterm (plnohodnotny terminal, vyzaduje balicek)
(define-key salix/leader-map (kbd "e e") #'eshell)
(define-key salix/leader-map (kbd "e v") #'vterm)

;; Markdown
;; - m g: grip-mode (nahled v prohlizeci)
;; - m h: prepnuti skryvani markup znaku
(define-key salix/leader-map (kbd "m g") #'grip-mode)
(define-key salix/leader-map (kbd "m h") #'markdown-toggle-markup-hiding)

;; Git
;; - g g/f: magit (zatim nenainstalovan)
;; - g t: git-timemachine (prochazeni historie souboru)
(define-key salix/leader-map (kbd "g g") #'magit-status)
(define-key salix/leader-map (kbd "g f") #'magit-file-dispatch)
(define-key salix/leader-map (kbd "g t") #'git-timemachine)

;; Globalni zkratky
;; - escape: univerzalni cancel key (nahradi C-g)
;; - C-=/C--/C-0: zmena velikosti fontu (reset na C-0)
;; - C-x C-j: dired-jump (rozsiri vychozi C-x d)
;; - j j: avy-goto-char-2 (skok na dva znaky na obrazovce)
(global-set-key (kbd "<escape>") #'keyboard-escape-quit)

(global-set-key (kbd "C-=") #'text-scale-increase)
(global-set-key (kbd "C--") #'text-scale-decrease)
(global-set-key (kbd "C-0")
                (lambda () (interactive) (text-scale-set 0)))

(global-set-key (kbd "C-x C-j") #'dired-jump)

(define-key salix/leader-map (kbd "j j") #'avy-goto-char-2)

;; Vlastni funkce pro editaci
;; - M-S-up/down: presun aktualniho radku
;; - C-return: novy radek pod aktualni (jako VS Code)
;; - C-': duplikace aktualniho radku
(defun salix/move-line-up ()
  "Move the current line up by one."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun salix/move-line-down ()
  "Move the current line down by one."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key (kbd "M-S-<up>")   #'salix/move-line-up)
(global-set-key (kbd "M-S-<down>") #'salix/move-line-down)

(global-set-key (kbd "C-<return>")
                (lambda ()
                  (interactive)
                  (end-of-line)
                  (newline-and-indent)))

(defun duplicate-line ()
  "Duplicate the current line."
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (move-beginning-of-line 1)
      (kill-line)
      (yank)
      (open-line 1)
      (forward-line 1)
      (yank))
    (move-to-column col)))

(global-set-key (kbd "C-'") #'duplicate-line)

(provide 'salix-keybindings)

;;; salix-keybindings.el ends here
