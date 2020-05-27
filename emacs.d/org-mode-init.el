(require 'org)

;; (require 'stripe-buffer)
;; (add-hook 'org-mode-hook 'stripe-table-mode)
;; (add-hook 'org-mode-hook 'autopair-mode)

(defun self/-org-mode-before-save-hook ()
  "Update the org-statistics in the entire file"
  (interactive)
  (let ((current-prefix-arg 4)) ;; emulate C-u
    ;; invoke align-regexp interactively
    (call-interactively 'org-update-statistics-cookies)))

(defun self/-org-mode ()
  "org mode customization"
  ;; Always use org indent minor mode
  (org-indent-mode)

  (org-bullets-mode 1)

  (yas-minor-mode 1)

  ;; Always use visual-line-mode
  (visual-line-mode 1)

  ;; Enable flyspell minor mode in org
  (flyspell-mode 1)

  ;; Enabling writegood mode for org documents
  (writegood-mode 1)

  ;; Removing conflicting keys from smartparens minor-mode in org-mode
  (let ((oldmap (cdr (assoc 'smartparens-mode minor-mode-map-alist)))
        (newmap (make-sparse-keymap)))
    (set-keymap-parent newmap oldmap)
    (define-key newmap (kbd "<M-up>") nil)
    (define-key newmap (kbd "<M-down>") nil)
    ;; Conflicts with org-mode source code buffer
    (define-key newmap (kbd "C-c '") nil)
    (make-local-variable 'minor-mode-overriding-map-alist)
    (push `(smartparens-mode . ,newmap) minor-mode-overriding-map-alist))

  (smartparens-mode 1)
  (add-hook 'before-save-hook 'self/-org-mode-before-save-hook nil 'make-it-local)

  (setq org-replace-disputed-keys t)

  ;; Using Shift keys for navigation across windows
  (windmove-default-keybindings)

  (define-key org-mode-map (kbd "<S-right>") 'windmove-right)
  (define-key org-mode-map (kbd "<S-left>") 'windmove-left)
  (define-key org-mode-map (kbd "<S-up>") 'windmove-up)
  (define-key org-mode-map (kbd "<S-down>") 'windmove-down))

(add-hook 'org-mode-hook 'self/-org-mode)

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

;; required for org-reveal mode presentations
(require 'ox-reveal)

;; search and replace inside invisible content (like urls) in org mode
;; (load "~/.emacs.d/vendor/org-mode-search-invisible.el")
