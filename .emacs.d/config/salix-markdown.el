;;; salix-markdown.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Nastavi markdown-mode a osobni stylovani.
;; Goldman font pro nadpisy, velikosti podle urovne.
;; Grip-mode umoznuje nahled v prohlizeci pres GitHub API.

;;; Code:

;; Markdown-mode - zakladni nastaveni
;; - pandoc jako renderer nahledu
;; - skryti markup znaku, nativni zvyrazneni kodu v blocich
(use-package markdown-mode
  :init
  (setq markdown-command "pandoc")
  :config
  (setq markdown-hide-markup t
        markdown-asymmetric-header t
        markdown-header-scaling t
        markdown-fontify-code-blocks-natively t)
  (add-hook 'markdown-mode-hook #'visual-line-mode))

;; Grip-mode - nahled v prohlizeci pres GitHub API
;; - vyzaduje: pipx install grip
;; - spustit: M-. m g
(use-package grip-mode
  :commands grip-mode)

;; Font pro nadpisy (pouziva se i v salix-org-ui.el)
(defvar salix/markdown-heading-font "Goldman"
  "Font used for Markdown headings.")

;; Funkce pro osobni stylovani markdown
;; - tema ridi barvy, my ridime font a velikost nadpisu
;; - Goldman font s fallbackem na vychozi font
;; - kod dedi fixed-pitch s pruhlednym pozadim
(defun salix/markdown-apply-faces ()
  "Apply personal Markdown styling without overriding theme colors."
  (when (facep 'markdown-header-face-1)
    (let ((heading-font (if (find-font (font-spec :name salix/markdown-heading-font))
                            salix/markdown-heading-font
                          (face-attribute 'default :family))))
      (custom-set-faces
       `(markdown-header-face-1 ((t (:inherit outline-1
                                    :family ,heading-font
                                    :height 1.25
                                    :weight bold))))
       `(markdown-header-face-2 ((t (:inherit outline-2
                                    :family ,heading-font
                                    :height 1.20
                                    :weight bold))))
       `(markdown-header-face-3 ((t (:inherit outline-3
                                    :family ,heading-font
                                    :height 1.15
                                    :weight bold))))
       `(markdown-header-face-4 ((t (:inherit outline-4
                                    :family ,heading-font
                                    :height 1.10
                                    :weight bold))))
       `(markdown-list-face ((t (:height 0.85))))
       `(markdown-inline-code-face ((t (:inherit fixed-pitch
                                        :foreground "#83a598"
                                        :height 1.0
                                        :background "transparent"))))
       `(markdown-code-face ((t (:inherit fixed-pitch
                                 :height 1.0
                                 :background "transparent"))))))))

;; Aplikace stylu po nacteni tematu a markdown-mode
;; - advice zajisti obnovu stylu pri prepnuti tematu
(advice-add 'load-theme :after
            (lambda (&rest _)
              (salix/markdown-apply-faces)))

(with-eval-after-load 'markdown-mode
  (salix/markdown-apply-faces))

(provide 'salix-markdown)

;;; salix-markdown.el ends here
