;; reference - https://writequit.org/articles/working-with-logs-in-emacs.html#b-b-b-bonus
(use-package log4j-mode
  :ensure t
  :disabled t
  :init
  (add-hook #'log4j-mode-hook #'view-mode)
  (add-hook #'log4j-mode-hook #'read-only-mode)
  (add-hook #'log4j-mode-hook 'eos/turn-on-hl-line))
