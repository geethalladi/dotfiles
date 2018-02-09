;; Half page scrolling

(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))

(defun scroll-up-half ()
  (interactive)
  (scroll-up (window-half-height)))

(defun scroll-down-half ()
  (interactive)
  (scroll-down (window-half-height)))

(global-set-key (kbd "s-<up>") 'scroll-down-half)
(global-set-key (kbd "s-<down>") 'scroll-up-half)

(global-set-key (kbd "C-x <up>") 'scroll-down-half)
(global-set-key (kbd "C-x <down>") 'scroll-up-half)

(global-set-key (kbd "s-/") 'comment-region)

;; Multiple Cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(require 'smartparens-config)

;; For associating pomodoro with lisp mode
(add-to-list 'auto-mode-alist '("\\.pomo" . lisp-mode))

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

(global-set-key (kbd "C-c b") 'switch-to-previous-buffer)

;; FIX THE PATH VARIABLE
;; (defun set-exec-path-from-shell-PATH ()
;;   (let ((path-from-shell (shell-command-to-string "TERM=vt100 $SHELL -i -c 'echo $PATH'")))
;;     (setenv "PATH" path-from-shell)
;;     (setq exec-path (split-string path-from-shell path-separator))))
;; (when window-system (set-exec-path-from-shell-PATH))

;; dir local variables
(put 'mocha-which-node 'safe-local-variable #'stringp)
(put 'mocha-command 'safe-local-variable #'stringp)
(put 'mocha-environment-variables 'safe-local-variable #'stringp)
(put 'mocha-options 'safe-local-variable #'stringp)
(put 'mocha-project-test-directory 'safe-local-variable #'stringp)
(put 'mocha-reporter 'safe-local-variable #'stringp)
