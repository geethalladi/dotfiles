(require 'org)
;; (require 'stripe-buffer)

;; Always use org indent minor mode
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'autopair-mode)

;; (add-hook 'org-mode-hook 'stripe-table-mode)
;; (add-hook 'org-mode-hook 'smartparens-mode)

;; List of file extensions to use org-mode for (org|org_archive|notes)
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|notes\\|pomodoro\\)$" . org-mode))

;; Key Bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; List of ORG mode todo list
(setq org-todo-keywords
      '((sequence "TODO" "DOING" "WAITING" "|" "DONE" "DROPPED")))

;; Indent inside source code blocks
(setq org-src-tab-acts-natively t)

;; Display images inline
(setq org-startup-with-inline-images t)

;; Using Shift keys for navigation across windows
(windmove-default-keybindings)
(setq org-replace-disputed-keys t)

;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)


(add-to-list 'org-emphasis-alist
             '("_" (:foreground "red")))

;; Visually identify DONE/Completed Items
(setq org-fontify-done-headline t)
(custom-set-faces
 '(org-done ((t (:foreground "ForestGreen"
                 :weight normal
                 :strike-through t))))
 '(org-headline-done
            ((((class color) (min-colors 16) (background dark))
               (:foreground "LightSalmon" :strike-through t)))))

;; Emacs macro to add a pomodoro item
(fset 'pomodoro
      "[ ]")

;; Emacs macro to add a pomodoro table
;;
;; | G | Daily | [ ] |
;; |   |       |     |
(fset 'pomodoro-table
      [?| ?  ?G ?  ?| ?  ?D ?a ?i ?l ?y ? ?  ?| ?  ?\[ ?  ?\] ?  ?| tab])

(require 'ox-confluence)

(load "~/.emacs.d/org-agenda-init.el")
