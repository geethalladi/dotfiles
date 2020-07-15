(add-to-list 'load-path "~/.emacs.d/.cask/26.0/elpa/go-mode-20170726.555/go-mode.el")

(require 'go-mode)
(require 'go-mode-autoloads)

(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

;; uses native auto completion (M-TAB)
;; (depends-on "go-complete")
;; (add-hook 'completion-at-point-functions 'go-complete-at-point)

(add-hook 'go-mode-hook 'smartparens-mode)
(add-hook 'go-mode-hook 'projectile-mode)
(add-hook 'go-mode-hook 'yafolding-mode)
