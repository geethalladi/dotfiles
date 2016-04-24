;; ;; JavaScript

;; (load "~/.emacs.d/lisp-init.el")

(require 'js2-mode)

(setq js2-highlight-level 3)

(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(require 'smartparens)
(add-hook 'js-mode-hook 'smartparens-mode)
;; (add-hook 'js-mode-hook
;;           (lambda ()
;;             (slime-js-minor-mode 1)))
(add-hook 'js-mode-hook
          (lambda ()
            (moz-minor-mode 1)))
(add-hook 'js-mode-hook 'ac-js2-mode)

;; (define-key js-mode-map "{" 'paredit-open-curly)
;; (define-key js-mode-map "}" 'paredit-close-curly-and-newline)

;; TODO
;; (global-set-key [f5] 'slime-js-reload)
(setq js2-basic-offset 2)
