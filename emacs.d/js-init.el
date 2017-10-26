;; ;; JavaScript

;; (load "~/.emacs.d/lisp-init.el")

(require 'js2-mode)
(require 'js-doc)
(require 'smartparens)
(require 'discover-js2-refactor)
(require 'tern)

(setq js2-highlight-level 3)

;; (add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(defun js-mode-configuration-hook ()
  (local-set-key (kbd "C-c m") 'makey-key-mode-popup-js2-refactor)
  (make-variable-buffer-local 'js-indent-level)
  (setq js-indent-level 2))

;; (add-hook 'js-mode-hook
;;           (lambda ()
;;             (slime-js-minor-mode 1)))

;; Mozilla REPL
;; (add-hook 'js-mode-hook
;;           (lambda ()
;;             (moz-minor-mode 1)))

(add-hook 'js-mode-hook 'smartparens-mode)
(add-hook 'js-mode-hook 'ac-js2-mode)

(add-hook 'js2-mode-hook #'js2-refactor-mode)
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)
(add-hook 'js-mode-hook 'js-mode-configuration-hook)

;; (define-key js-mode-map "{" 'paredit-open-curly)
;; (define-key js-mode-map "}" 'paredit-close-curly-and-newline)

;; TODO
;; (global-set-key [f5] 'slime-js-reload)
(setq js2-basic-offset 2)

(add-hook 'json-mode 'flymake-json-load)

(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
       (tern-ac-setup)
       (tern-context-coloring-setup)))

(add-hook 'js2-mode-hook 'tern-mode)

(load-file "~/dotfiles/emacs.d/skewer-coffee.el")
(require 'skewer-coffee)

(add-hook 'coffee-mode-hook 'skewer-coffee-mode)
(add-hook 'coffee-mode-hook 'smartparens-mode)

;; Adding purescirpt mode to the initial loading list
(require 'purescript-mode)
;; The below does not work for me :-)
;; (require 'purescript-mode-autoloads)
