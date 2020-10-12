(require 'js2-mode)
(require 'smartparens)
(require 'json-snatcher)
(require 'tern)
(require 'js2-refactor)
(require 'discover-js2-refactor)
(require 'js-doc)
(require 'mocha)
(require 'nvm)
(require 'nodejs-repl)
;; (require 'indium)  ;; uncomment after fixing json-client-process issue in emacs 27
(require 'xref-js2)

;; needed for making the tern-server integration
;; know this is ugly; A Stop-gap solution for finding node
(let ((node-exec-path (expand-file-name "~/.nvm/versions/node/v8.9.4/bin")))
  ;; setting the node-executable path in both the forms of PATH variables
  (setq exec-path
        (append exec-path (list node-exec-path)))
  (setenv "PATH"
          (concat node-exec-path ":" (getenv "PATH"))))

;; Moving tern mode to the top
;; tern keymap clashes with js2-refactor mode
;; Moving it to the top, to resolve in favour of js2-refactor mode
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
       (tern-ac-setup)
       (tern-context-coloring-setup)))

;; Use js-mode for editing json files
;; (add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))

;; (add-hook 'js-mode-hook #'flycheck-mode)
;; (add-hook 'json-mode 'flymake-json-load)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; (add-to-list 'auto-mode-alist '("\\.json$" . web-mode))

;; Handlebar templates to use web-mode
(add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))


(defun self/-web-customizations ()
  "Customizations for web mode"
  (define-key web-mode-map "\C-cp" 'jsons-print-path))

(defun self/-js-keybindings ()
  "Updating keybindings for javascript"

  (local-set-key (kbd "C-c m") 'makey-key-mode-popup-js2-refactor)
  (define-key js2-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
  (define-key js2-mode-map (kbd "C-c C-j") 'nodejs-repl-send-line)
  (define-key js2-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
  (define-key js2-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
  (define-key js2-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)

  (define-key js2-mode-map "\C-ci" 'js-doc-insert-function-doc)
  (define-key js2-mode-map "@" 'js-doc-insert-tag)
  (define-key js2-mode-map "\C-ct" 'mocha-test-at-point)
  (define-key js2-mode-map (kbd "C-k") #'js2r-kill)

  (js2r-add-keybindings-with-prefix "C-c C-r")

  ;; dir local variables
  (put 'mocha-which-node 'safe-local-variable #'stringp)
  (put 'mocha-command 'safe-local-variable #'stringp)
  (put 'mocha-environment-variables 'safe-local-variable #'stringp)
  (put 'mocha-options 'safe-local-variable #'stringp)
  (put 'mocha-project-test-directory 'safe-local-variable #'stringp)
  (put 'mocha-reporter 'safe-local-variable #'stringp))

(defun self/-js-customizations ()
  "javascript mode customizations"
  (setq js2-highlight-level 3)
  (setq js2-include-node-externs t)
  (setq js2-basic-offset 2)

  ;; Enable this if you want constant indendation in js2-mode
  ;; (custom-set-variables
  ;;  '(js2-basic-offset 2)
  ;;  '(js2-bounce-indent-p t))

  (make-variable-buffer-local 'js-indent-level)
  (setq js-indent-level 2)

  ;; js-mode is used while rendering JSON response
  ;; Use yafolding mode with js-mode
  (yafolding-mode)
  (smartparens-mode)

  ;; (js2-minor-mode)
  (tern-mode)
  (js2-refactor-mode)
  (indium-interaction-mode)

  (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)
  (self/-js-keybindings))

(defun self/-json-customizations ()
  "JSON mode customizations"

  (make-variable-buffer-local 'js-indent-level)
  (setq js-indent-level 2)

  ;; Comments in json mode ;; Use // for comments
  (let ((json-mode-comments-re (rx (group "//" (zero-or-more nonl) line-end))))
      (push (list json-mode-comments-re 1 font-lock-comment-face) json-font-lock-keywords-1))

  (yafolding-mode)
  (smartparens-mode)
  (rainbow-delimiters-mode))

(add-hook 'js2-mode-hook 'self/-js-customizations)
(add-hook 'web-mode-hook 'self/-web-customizations)
(add-hook 'json-mode-hook 'self/-json-customizations)

;; node js repl may override some skewer related shortcuts
;; skewer is for web development (may not be specific to nodejs)

;; (add-hook 'js2-mode-hook 'ac-js2-mode)

;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
;; unbind it.
(eval-after-load 'ac-js2
  '(progn
     (define-key ac-js2-mode-map (kbd "M-.") nil)))

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
