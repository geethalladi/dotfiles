;; Always use org indent minor mode
(add-hook 'org-mode-hook 'org-indent-mode)

;; List of file extensions to use org-mode for (org|org_archive|notes)
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|notes\\)$" . org-mode))

;; Key Bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; List of ORG mode todo list
(setq org-todo-keywords
      '((sequence "ICEBOX" "TODO" "PROGRESS" "DONE")))

;; org agenda files
(setq org-agenda-files (quote ("~/Documents/personal/organiser")))

;; Display images inline
(setq org-startup-with-inline-images t)
