(defun self/scheme-mode ()
  "Customizations of scheme mode"
  (smartparens-mode)
  (rainbow-delimiters-mode))

(setq inferior-lisp-program "/usr/local/bin/sbcl")

(require 'slime)
(require 'slime-scratch)

(slime-setup)

(setq inferior-lisp-program "/usr/local/bin/sbcl --noinform")

(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'smartparens-mode)

(add-hook 'slime-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'inferior-lisp-mode-hook 'rainbow-delimiters-mode)

;; paredit mode for slime mode
(add-hook 'slime-repl-mode-hook (lambda () (smartparens-mode)))
;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

;; Customisations for scheme

(custom-set-variables '(scheme-program-name "petite"))

(setq scheme-program-name "petite")

(setq geiser-active-implementations '(chez))

(setq geiser-default-implementation 'chez)

;; Disable version check
(setq geiser-repl-skip-version-check-p 't)

(setq geiser-chez-binary "/usr/local/bin/chez")

(require 'geiser)
(require 'quack)

(add-hook 'scheme-mode-hook 'self/scheme-mode)

(add-to-list 'auto-mode-alist '("\\.scm$" . scheme-mode))

(add-to-list 'auto-mode-alist '("\\.ss$" . scheme-mode))
