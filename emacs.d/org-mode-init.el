(require 'org)
;; Always use org indent minor mode
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'autopair-mode)
;; (add-hook 'org-mode-hook 'smartparens-mode)

;; List of file extensions to use org-mode for (org|org_archive|notes)
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|notes\\|pomodoro\\)$" . org-mode))

;; Key Bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; List of ORG mode todo list
(setq org-todo-keywords
      '((sequence "TODO" "PROGRESS" "DONE" "ICEBOX")))

;; org agenda files
(setq org-agenda-files (quote ("~/Documents/personal/organiser")))

;; Display images inline
(setq org-startup-with-inline-images t)

(add-to-list 'org-emphasis-alist
 '("*" (:foreground "red")))

;; Emacs macro to add a pomodoro item
(fset 'pomodoro
      "[ ]")

;; Emacs macro to add a pomodoro table
;;
;; | G | Daily | [ ] |
;; |   |       |     |
(fset 'pomodoro-table
      [?| ?  ?G ?  ?| ?  ?D ?a ?i ?l ?y ? ?  ?| ?  ?\[ ?  ?\] ?  ?| tab])
