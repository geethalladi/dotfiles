;; ;; JavaScript

(load "~/.emacs.d/lisp-init.el")

(require 'smartparens)
(require 'js2-mode)

(setq js2-highlight-level 3)

(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-hook 'js2-mode-hook 'ac-js2-mode)

(define-key js-mode-map "{" 'paredit-open-curly)
(define-key js-mode-map "}" 'paredit-close-curly-and-newline)

(global-set-key [f5] 'slime-js-reload)
(add-hook 'js2-mode-hook
          (lambda ()
            (slime-js-minor-mode 1)))
(add-hook 'js2-mode-hook
          (lambda ()
            (moz-minor-mode 1)))

(setq js2-basic-offset 2)
