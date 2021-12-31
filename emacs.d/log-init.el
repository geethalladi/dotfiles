;; reference - https://writequit.org/articles/working-with-logs-in-emacs.html#b-b-b-bonus
(use-package log4j-mode
  :ensure t
  :disabled t
  :init
  (add-hook #'log4j-mode-hook #'view-mode))

(defun self/log4j-mode ()
  "Log4j customizations"
  (message "running log4j customizations")
  (view-mode)
  (read-only-mode)
  (self/use-terminal-font))

(add-hook 'log4j-mode-hook 'self/log4j-mode)
