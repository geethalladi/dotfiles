(add-to-list 'load-path "~/.emacs.d/.cask/26.0/elpa/go-mode-20170726.555/go-mode.el")

(require 'go-mode)
;; (require 'go-mode-autoloads)


(add-hook 'go-mode-hook 'smartparens-mode)
(add-hook 'go-mode-hook 'projectile-mode)
;; (add-hook 'go-mode-hook 'yafolding-mode)
;; (add-hook 'go-mode-hook '
