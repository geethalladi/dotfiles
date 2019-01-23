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
(setq-default cursor-type 'bar)

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
