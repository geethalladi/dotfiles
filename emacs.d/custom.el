;; Half page scrolling

(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))

(defun scroll-up-half ()
  (interactive)
  (scroll-up (window-half-height)))

(defun scroll-down-half ()
  (interactive)
  (scroll-down (window-half-height)))

;; Setting global prettify-symbols-mode
(global-prettify-symbols-mode +1)

(global-set-key (kbd "s-<up>") 'scroll-down-half)
(global-set-key (kbd "s-<down>") 'scroll-up-half)

;; (global-set-key (kbd "s-f") 'isearch-forward-regexp)
;; (global-set-key (kbd "s-b") 'isearch-backward-regexp)
(global-set-key (kbd "s-r") 'query-replace-regexp)

(global-set-key (kbd "C-x <up>") 'scroll-down-half)
(global-set-key (kbd "C-x <down>") 'scroll-up-half)

(global-set-key (kbd "s-/") 'comment-region)

;; Till I find out how to encode "Command + p"
;; ;; Press Command-p for fuzzy find in project
(global-set-key (kbd "M-p") 'projectile-find-file)
;; ;; Press Command-b for fuzzy switch buffer
(global-set-key (kbd "M-b") 'projectile-switch-to-buffer)

;; Displaying cursors
;; (setq-default cursor-type 'bar)

;; Don't blink the cursor
(blink-cursor-mode 0)

;; Multiple Cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(require 'smartparens-config)

(setenv "LC_CTYPE" "UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LANG" "en_US.UTF-8")

;; Elastic Search mode
(add-to-list 'auto-mode-alist '("\\.es$" . es-mode))
(add-hook 'es-result-mode-hook 'hs-minor-mode)

(defvar es-default-base "http://localhost:9200")
(defvar nginx-indent-level 2)

;; C-h for delete-backward-char
;; (global-set-key [(control ?h)] 'delete-backward-char)

;; Get all the environment variables from shell
(exec-path-from-shell-copy-env "PYTHONPATH")
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

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
(setq irfc-directory "~/dotfiles/emacs.d/.irfc")
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

(setq explicit-shell-file-name "/bin/zsh")

(require 'flyspell)

(defun self/flyspell-save-word ()
  (interactive)
  (let ((current-location (point))
         (word (flyspell-get-word)))
    (when (consp word)
      (flyspell-do-correct 'save nil (car word) current-location (cadr word) (caddr word) current-location))))

;; Enabling googling from emacs
(google-this-mode 1)

;; Hide from appearing as sub-modes
(diminish 'google-this-mode)
(diminish 'helm-mode)
(diminish 'projectile-mode)
