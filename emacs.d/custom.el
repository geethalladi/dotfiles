;; Half page scrolling

(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))

(defun scroll-up-half ()
  (interactive)
  (scroll-up (window-half-height)))

(defun scroll-down-half ()
  (interactive)
  (scroll-down (window-half-height)))

;; ref: http://www.emacswiki.org/emacs-en/download/misc-cmds.el
(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive)
    (revert-buffer :ignore-auto :noconfirm))

;; Setting global prettify-symbols-mode
(global-prettify-symbols-mode +1)

(global-set-key (kbd "s-<up>") 'scroll-down-half)
(global-set-key (kbd "s-<down>") 'scroll-up-half)

;; (global-set-key (kbd "s-f") 'isearch-forward-regexp)
;; (global-set-key (kbd "s-b") 'isearch-backward-regexp)
(global-set-key (kbd "s-r") 'query-replace-regexp)

(global-set-key (kbd "C-x <up>") 'scroll-down-half)
(global-set-key (kbd "C-x <down>") 'scroll-up-half)
(global-set-key (kbd "C-=") 'er/expand-region)

(global-set-key (kbd "s-/") 'comment-region)

;; Till I find out how to encode "Command + p"
;; ;; Press Command-p for fuzzy find in project
(global-set-key (kbd "M-p") 'projectile-find-file)
;; ;; Press Command-b for fuzzy switch buffer
(global-set-key (kbd "M-b") 'projectile-switch-to-buffer)

;; cycle between the last two buffers
(global-set-key (kbd "M-o")  'mode-line-other-buffer)

;; Displaying cursors

;; (setq-default cursor-type 'bar)
;; (blink-cursor-mode 1)

(setq-default cursor-type 'box)

;; Automatically insert new characters into the selected region
(pending-delete-mode 1)

;; Multiple Cursors
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(require 'smartparens-config)

(setenv "LC_CTYPE" "UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LANG" "en_US.UTF-8")

;; emacs getting the same path when invoked from GUI
;; Get all the environment variables from shell
;; (exec-path-from-shell-copy-env "PYTHONPATH")
(when (memq window-system '(mac ns x))
  (setq exec-path-from-shell-check-startup-files nil)
  (require 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

;; Elastic Search mode
(add-to-list 'auto-mode-alist '("\\.es$" . es-mode))
(add-hook 'es-result-mode-hook 'hs-minor-mode)

(defvar es-default-base "http://localhost:9200")
(defvar nginx-indent-level 2)

;; C-h for delete-backward-char
;; (global-set-key [(control ?h)] 'delete-backward-char)

;; Setting key for global multiple cursor mode
(global-set-key (kbd "C-c m c") 'mc/edit-lines)

;; Indenting buffer / region

;; reference: https://emacsredux.com/blog/2013/03/27/indent-region-or-buffer/

(defun self/indent-buffer ()
  "Indent the currently visited buffer."
  (message "Indenting buffer.")
  (interactive)
  (indent-region (point-min) (point-max)))

(defun self/indent-region ()
  "Indent the currently selected region."
  (message "Indenting selected region.")
  (indent-region (region-beginning) (region-end)))

(defun self/indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn (self/indent-region))
      (progn (self/indent-buffer)))))

(global-set-key (kbd "C-M-\\") #'self/indent-region-or-buffer)

;; Toggling between buffers
(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
   Repeated invocations toggle between the two
   most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;;; Copied from "https://stackoverflow.com/questions/1587972/how-to-display-indentation-guides-in-emacs/4459159#4459159"
;;; Toggle fold indented lines
(defun toggle-fold-indented-lines ()
  "Toggle fold all lines larger than indentation on current line"
  (interactive)
  (let ((col 1))
    (save-excursion
      (back-to-indentation)
      (setq col (+ 1 (current-column)))
      (set-selective-display
       (if selective-display nil (or col 1))))))

(global-set-key (kbd "C-c b") 'switch-to-previous-buffer)

;; M-b is rebound in helm; Undoing this by manually binding this here
(global-set-key (kbd "M-b") 'backward-word)

;; Key binding for magit-status
(global-set-key (kbd "C-c g s") 'magit-status)

;; Key binding for mac
(global-set-key [(super a)] 'mark-whole-buffer)
(global-set-key [(super v)] 'yank)
(global-set-key [(super c)] 'kill-ring-save)
(global-set-key [(super s)] 'save-buffer)
(global-set-key [(super l)] 'goto-line)
(global-set-key [(super w)]
                (lambda () (interactive) (delete-window)))
(global-set-key [(super z)] 'undo)
(global-set-key [(super k)] 'kill-current-buffer)

;; Follow symlinks
(setq vc-follow-symlinks t)

;; FIX THE PATH VARIABLE
;; (defun set-exec-path-from-shell-PATH ()
;;   (let ((path-from-shell (shell-command-to-string "TERM=vt100 $SHELL -i -c 'echo $PATH'")))
;;     (setenv "PATH" path-from-shell)
;;     (setq exec-path (split-string path-from-shell path-separator))))
;; (when window-system (set-exec-path-from-shell-PATH))

;;;;;;;;;;;;;;;;;;;;;
;;; neotree mode  ;;;
;;;;;;;;;;;;;;;;;;;;;

;; DIRTREE MODE
;; (require 'dirtree) ;; FOR OPTIMIZATION
(require 'all-the-icons)
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-smart-open t) ;; Flag to open neotree for the current dir
(setq-default neo-show-hidden-files t)

;; Avoid opening new frames
(setq split-window-preferred-function 'neotree-split-window-sensibly)

(setq neo-show-hidden-files nil)

(eval-after-load "neotree"
  '(setq neo-hidden-regexp-list
         '("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" "^__pycache__$")))

;; rfc mode

(require 'irfc)
(setq irfc-directory (expand-file-name ".irfc" user-emacs-directory))
(setq irfc-download-base-url "https://www.ietf.org/rfc/")
(setq irfc-assoc-mode t)

(add-to-list 'auto-mode-alist '("rfc[0-9]+.txt\\'" . irfc-mode))

;; ov-highlighter mode

(require 'ov)
(require 'ov-highlighter)
(global-set-key (kbd "H-h") 'ov-highlighter/body)

;; ag reuse buffers
(setq ag-reuse-buffers 't)
(setq ag-reuse-window 't)

;; rg settings
(require 'rg)
(rg-enable-default-bindings)
(global-set-key (kbd "C-c s") #'rg-menu)

(setq explicit-shell-file-name "/bin/zsh")

(require 'flyspell)

(defun self/flyspell-save-word ()
  (interactive)
  (let ((current-location (point))
        (word (flyspell-get-word)))
    (when (consp word)
      (flyspell-do-correct 'save nil (car word) current-location (cadr word) (caddr word) current-location))))

;; Enabling googling from emacs
(require 'google-this)
(google-this-mode 1)

(setq org-reveal-root "file:///opt/reveal.js")

(setq mac-shift-modifier 'meta)
(setq ns-function-modifier 'hyper)  ; make Fn key do Hyper

(require 'visual-fill-column)
(setq-default fill-column 120)
(setq visual-fill-column-width 185)
(global-visual-fill-column-mode 1)

;; (require 'better-defaults)
;; (require 'ido)
;; (ido-mode 1)
;; (setq ido-everywhere t)
;; (setq ido-enable-flex-matching t)

;; autocompletion in M-x
;; (require 'smex)
;; (global-set-key (kbd "M-x") 'smex)

;; [TODO] Update the exact path of the dictinoary
;; (add-to-list 'ac-dictionary-directories
;;   (expand-file-name ".cask/24.5.1/elpa/auto-complete-20160710.1544/dict" user-emacs-directory))

;; turning off linum-mode as an experimentation
;; (global-linum-mode 1)
;; (setq linum-format "%3d ")

;; TAB
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq standard-indent 2)
(setq c-basic-indent 2)
(setq tab-width 2)

;; (setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)
;; (highlight-tabs)
;; (highlight-trailing-whitespace)

;; wind move is moving through multiple windows(panes)
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; Key Binding C-cl for clearning buffer
(defun erase-buffer-hook ()
  (local-set-key "\C-cl" 'erase-buffer))
(add-hook 'shell-mode-hook 'erase-buffer-hook)

;; Found a way to overwrite the selected text and replace it with
;; the yanked content
;; (delete-selection-mode 1)

;; No more visible bell ;; black rectangle in the center
(setq visible-bell nil)

;; Enable menu-mar mode
(menu-bar-mode 1)

;; Mod line mode
(line-number-mode t)
(visual-line-mode 1)
(column-number-mode t)

;; magit for GIT
(require 'magit)

(require 'toggle-quotes)
(global-set-key (kbd "C-'") 'toggle-quotes)

;; Disabling menu bar in terminals
(unless (display-graphic-p)
  (message "Disabling menu bar")
  (menu-bar-mode -1))

;; for emacs sentence navigation
;; without this setting, the keybinding moves every paragraph
(setq sentence-end-double-space nil)

;; when bookmarks are added, save it to disk immediately
(setq bookmark-save-flag 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; pandoc output options
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; default options for all output formats
(setq org-pandoc-options '((standalone . t)))

;; cancel above settings only for 'docx' format
(setq org-pandoc-options-for-docx '((standalone . nil)))

;; special settings for beamer-pdf and latex-pdf exporters
(setq org-pandoc-options-for-beamer-pdf '((pdf-engine . "xelatex")))

(setq org-pandoc-options-for-latex-pdf '((pdf-engine . "pdflatex")))

;; special extensions for markdown_github output
(setq org-pandoc-format-extensions '(markdown_github+pipe_tables+raw_html))

(defun self/org-extract-link (&optional arg)
  "Extract URL from org-mode link"
  (let* ((link (org-element-lineage (org-element-context) '(link) t))
          (type (org-element-property :type link))
          (url (org-element-property :path link)))
    (concat type ":" url)))

(defun self/threadreader-app (url)
  "Open the twitter URL in threadreader"
  (browse-url
   (concat "https://threadreaderapp.com/search?q=" url)))

(defun self/org-open-threadreader (&optional arg)
  "Open the Twitter thread in threadreader app"
  (interactive "P")
  (self/threadreader-app
   (self/org-extract-link)))

;; Reference: https://www.masteringemacs.org/article/fixing-mark-commands-transient-mark-mode

(defun self/push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region
   Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))

(global-set-key (kbd "C-`") 'self/push-mark-no-activate)

(defun self/jump-to-mark ()
  "Jumps to the local mark, respecting the `mark-ring' order.
  This is the same as using \\[set-mark-command] with the prefix argument."
  (interactive)
  (set-mark-command 1))

(global-set-key (kbd "M-`") 'self/jump-to-mark)

;; requiring the packages
(require 'pocket-reader)
(require 'ebuku)
