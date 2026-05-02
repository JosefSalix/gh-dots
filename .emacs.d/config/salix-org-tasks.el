;;; salix-org-tasks.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi TODO workflow, capture templates a agenda pohledy.
;; Soubory: inbox.org pro ukoly a poznamky, daily.org pro denni zaznamy.

;;; Code:

;; TODO workflow a barvy stavu
;; - TODO/DOING/WAITING => DONE/CANCELED
;; - pismena v zavorkach jsou zkratky pro zmenu stavu
(setq org-todo-keywords
      '((sequence
         "TODO(t)"
         "DOING(d)"
         "WAITING(w)"
         "|"
         "DONE(x)"
         "CANCELED(c)")))

(setq org-todo-keyword-faces
      '(("TODO"     . (:foreground "#fb4934" :weight bold :height 0.8))
        ("DOING"    . (:foreground "#fabd2f" :weight bold :height 0.8))
        ("WAITING"  . (:foreground "#83a598" :weight bold :height 0.8))
        ("DONE"     . (:foreground "#b8bb26" :weight bold :height 0.8))
        ("CANCELED" . (:foreground "#928374" :weight bold :height 0.8))))

;; Zdrojove soubory pro agendu
(setq org-agenda-files
      '("~/org/daily.org"
        "~/org/inbox.org"))

;; Capture templates
;; - t: ukol do inbox.org s casem a odkazem
;; - n: rychla poznamka do inbox.org
;; - d: denni zaznam do daily.org (razeno podle data)
(setq org-capture-templates
      '(("t" "Task" entry
         (file+headline "~/org/inbox.org" "Inbox")
         "* TODO %?\n  %U\n  %a\n"
         :empty-lines 1)
        ("n" "Quick Note" entry
         (file+headline "~/org/inbox.org" "Inbox")
         "* %?\n  %U\n"
         :empty-lines 1)
        ("d" "Daily log" entry
         (file+olp+datetree "~/org/daily.org" "Daily")
         "* %?\n  %U\n"
         :empty-lines 1)))

;; Funkce pro otevreni dnesniho zaznamu v daily.org
;; - C-c o j: otevre nebo vytvori zaznam pro dnesni datum
(defun salix/org-open-daily ()
  "Open today's entry in daily.org."
  (interactive)
  (find-file "~/org/daily.org")
  (goto-char (point-max))
  (org-datetree-find-date-create (calendar-current-date)))

;; Vlastni agenda pohledy
;; - d: dnesni prehled (M-. o d) - priority, in progress, waiting
;; - w: tydenni prehled (M-. o w) - backlog a in progress
(setq org-agenda-custom-commands
      '(("d" "Today's focus"
         ((agenda ""
                  ((org-agenda-span 'day)
                   (org-deadline-warning-days 0)))
          (tags-todo "+PRIORITY=\"A\""
                     ((org-agenda-overriding-header "High priority:")))
          (todo "DOING"
                ((org-agenda-overriding-header "In progress:")))
          (todo "WAITING"
                ((org-agenda-overriding-header "Waiting on:")))
          (todo "TODO"
                ((org-agenda-overriding-header "Unscheduled tasks:")))))
        ("w" "Weekly review"
         ((agenda ""
                  ((org-agenda-span 'week)))
          (todo "DOING"
                ((org-agenda-overriding-header "In progress:")))
          (todo "WAITING"
                ((org-agenda-overriding-header "Waiting:")))
          (todo "TODO"
                ((org-agenda-overriding-header "Backlog:")))))))

;; Priority a chovani deadlines
;; - A/B/C: cervena/zluta/zelena (gruvbox)
;; - varovani 7 dni pred terminem
;; - splnene ukoly se v agende nezobrazuji
(setq org-priority-faces
      '((?A . (:foreground "#fb4934" :weight bold))
        (?B . (:foreground "#fabd2f" :weight bold))
        (?C . (:foreground "#83a598" :weight bold))))

(setq org-deadline-warning-days 7
      org-agenda-skip-deadline-if-done t
      org-agenda-skip-scheduled-if-done t)

(provide 'salix-org-tasks)

;;; salix-org-tasks.el ends here
