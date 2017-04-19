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
