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

(add-hook 'js2-mode-hook #'js2-refactor-mode)
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

;; (define-key js-mode-map "{" 'paredit-open-curly)
;; (define-key js-mode-map "}" 'paredit-close-curly-and-newline)

;; TODO
;; (global-set-key [f5] 'slime-js-reload)
(setq js2-basic-offset 2)

;; JSON MODE
(add-hook 'json-mode-hook
    (lambda ()
      (make-variable-buffer-local 'js-indent-level)
      (setq js-indent-level 2)))
(add-hook 'json-mode 'flymake-json-load)
(add-hook 'json-mode-hook 'paredit-mode)
(add-to-list 'auto-mode-alist '("\\.json" . json-mode))
