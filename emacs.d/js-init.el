;; ;; JavaScript

;; (load "~/.emacs.d/lisp-init.el")

(require 'js2-mode)
(require 'smartparens)

;; Moving tern mode to the top
;; tern keymap clashes with js2-refactor mode
;; Moving it to the top, to resolve in favour of js2-refactor mode

(require 'tern)
(add-hook 'js2-mode-hook 'tern-mode)
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
       (tern-ac-setup)
       (tern-context-coloring-setup)))

(require 'js2-refactor)
(require 'discover-js2-refactor)

(require 'js-doc)
(require 'mocha)
(require 'nvm)

(require 'nodejs-repl)

;; Use js-mode for editing json files
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
;; (add-hook 'js-mode-hook #'flycheck-mode)
;; (add-hook 'json-mode 'flymake-json-load)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . web-mode))
;; Handlebar templates to use web-mode
(add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))

(setq js2-highlight-level 3)
(setq js2-include-node-externs t)
(setq js2-basic-offset 2)

;; Know this is ugly; A Stop-gap solution for finding node
(setq exec-path (append exec-path
                        '("~/.nvm/versions/node/v8.9.4/bin")))

;; Enable this if you want constant indendation in js2-mode
;; (custom-set-variables
;;  '(js2-basic-offset 2)
;;  '(js2-bounce-indent-p t))

(defun js-mode-configuration-hook ()
  (local-set-key (kbd "C-c m") 'makey-key-mode-popup-js2-refactor)
  (make-variable-buffer-local 'js-indent-level)
  (setq js-indent-level 2))

;; js-mode is used while rendering JSON response
;; Use yafolding mode with js-mode
(add-hook 'js-mode-hook 'yafolding-mode)
(add-hook 'js-mode-hook 'js2-minor-mode)

;; node js repl may override some skewer related shortcuts
;; skewer is for web development (may not be specific to nodejs)
(add-hook 'js2-mode-hook
          (lambda ()
            (define-key js2-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
            (define-key js2-mode-map (kbd "C-c C-j") 'nodejs-repl-send-line)
            (define-key js2-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
            (define-key js2-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
            (define-key js2-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)))

(add-hook 'js2-mode-hook 'smartparens-mode)

(add-hook 'js2-mode-hook 'js-mode-configuration-hook)

(add-hook 'js2-mode-hook
          #'(lambda ()
              (define-key js2-mode-map "\C-ci" 'js-doc-insert-function-doc)
              (define-key js2-mode-map "@" 'js-doc-insert-tag)))

(add-hook 'js2-mode-hook
          #'(lambda ()
              (define-key js2-mode-map "\C-ct" 'mocha-test-at-point)))

(add-hook 'js2-mode-hook #'js2-refactor-mode)

(js2r-add-keybindings-with-prefix "C-c C-r")

(define-key js2-mode-map (kbd "C-k") #'js2r-kill)

;; (add-hook 'js2-mode-hook 'ac-js2-mode)

;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
;; unbind it.
(eval-after-load 'ac-js2
  '(progn
     (define-key ac-js2-mode-map (kbd "M-.") nil)))

(add-hook 'js2-mode-hook #'js2-refactor-mode)

(require 'xref-js2)
(add-hook 'js2-mode-hook (lambda ()
  (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

(require 'indium)
(add-hook 'js2-mode-hook #'indium-interaction-mode)

;; dir local variables
(put 'mocha-which-node 'safe-local-variable #'stringp)
(put 'mocha-command 'safe-local-variable #'stringp)
(put 'mocha-environment-variables 'safe-local-variable #'stringp)
(put 'mocha-options 'safe-local-variable #'stringp)
(put 'mocha-project-test-directory 'safe-local-variable #'stringp)
(put 'mocha-reporter 'safe-local-variable #'stringp)

;; (add-hook 'js-mode-hook
;;           (lambda ()
;;             (slime-js-minor-mode 1)))

;; Mozilla REPL
;; (add-hook 'js-mode-hook
;;           (lambda ()
;;             (moz-minor-mode 1)))

;; (add-hook 'js2-mode-hook 'skewer-mode)
;; (add-hook 'css-mode-hook 'skewer-css-mode)
;; (add-hook 'html-mode-hook 'skewer-html-mode)

;; (define-key js-mode-map "{" 'paredit-open-curly)
;; (define-key js-mode-map "}" 'paredit-close-curly-and-newline)

;; TODO
;; (global-set-key [f5] 'slime-js-reload)

;; (load-file "~/dotfiles/emacs.d/skewer-coffee.el")
;; (require 'skewer-coffee)
;; (add-hook 'coffee-mode-hook 'skewer-coffee-mode)

;; (add-hook 'coffee-mode-hook 'smartparens-mode)
