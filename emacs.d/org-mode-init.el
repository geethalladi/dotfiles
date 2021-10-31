(require 'org)

;; Required for old org mode templates to work (changed after org mode 9.2)
;; templates for source, quote blocks
(unless (version<= org-version "9.2")
  (require 'org-tempo))

;; (require 'stripe-buffer)
;; (add-hook 'org-mode-hook 'stripe-table-mode)
;; (add-hook 'org-mode-hook 'autopair-mode)

(defun self/-org-mode-before-save-hook ()
  "Update the org-statistics in the entire file"
  (interactive)
  (let ((current-prefix-arg 4)) ;; emulate C-u
    ;; invoke align-regexp interactively
    (call-interactively 'org-update-statistics-cookies)))

;; taken from https://emacs.stackexchange.com/questions/43651/moving-a-subtree-to-the-top-or-bottom-of-its-parent
(defun self/org-move-to-extreme (up)
  "Move current org subtree to the end of its parent.
  With prefix arg move subtree to the start of its parent."
  (interactive "P")
  (condition-case err
      (while t
        (funcall (if up
                     'org-move-subtree-up
                   'org-move-subtree-down)))
    (user-error
     (let ((err-msg (cadr err)))
       (unless (string-match "Cannot move past superior level or buffer limit" err-msg)
         (signal 'user-error (list err-msg)))))))

(defun self/-org-mode ()
  "org mode customization"
  ;; Always use org indent minor mode
  (org-indent-mode)

  ;; TODO: play around with variable width font for org mode
  ;; (self/use-variable-width-font)

  (org-bullets-mode 1)

  (yas-minor-mode 1)

  ;; Enable flyspell minor mode in org
  (flyspell-mode 1)

  ;; Enabling writegood mode for org documents
  (writegood-mode 1)
  (diminish 'writegood-mode)

  ;; Enabling word count mode
  (wc-mode)

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

  (setq fill-column 120)

  (auto-fill-mode t)
  (diminish 'auto-revert-mode)
  (diminish 'org-indent-mode)
  (diminish 'auto-fill-function)

  (setq org-replace-disputed-keys t)

  ;; do not truncate lines in org mode
  (toggle-truncate-lines)

  ;; Using Shift keys for navigation across windows
  (windmove-default-keybindings)

  (define-key org-mode-map (kbd "<S-right>") 'windmove-right)
  (define-key org-mode-map (kbd "<S-left>") 'windmove-left)
  (define-key org-mode-map (kbd "<S-up>") 'windmove-up)
  (define-key org-mode-map (kbd "<S-down>") 'windmove-down)
  (define-key org-mode-map (kbd "C-c M-w") 'org-refile))

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

;; Prefer width mentioned in the file
(setq org-image-actual-width nil)

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

;; org-roam configurations
(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      :custom
      ;; slipbox directory
      (org-roam-directory "~/slipbox")
      :bind (:map org-roam-mode-map
                  (("C-c r l" . org-roam)
                   ("C-c r f" . org-roam-find-file)
                   ("C-c r g" . org-roam-graph))
                  :map org-mode-map
                  (("C-c r i" . org-roam-insert))
                  (("C-c r I" . org-roam-insert-immediate))))

;; configurations for org-mind-map
;; taken from its README
(use-package org-mind-map
  :init
  (require 'ox-org)
  :ensure t
  ;; Uncomment the below if 'ensure-system-packages` is installed
  ;;:ensure-system-package (gvgen . graphviz)
  :config
  (setq org-mind-map-engine "twopi") ;; radial layout
  (setq org-mind-map-dot-output '("jpeg"))
  ;; this needs to be added at the end
  ;; as they are converted to CLI args
  ;; so the one coming last overrides the previous one
  (setq org-mind-map-default-graph-attribs
        (append org-mind-map-default-graph-attribs
                '(("autosize" . "true") ("size" . "20,20")))))

;; search and replace inside invisible content (like urls) in org mode
;; (load "~/.emacs.d/vendor/org-mode-search-invisible.el")
