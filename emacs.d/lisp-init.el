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
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
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

(setq auto-mode-alist (cons '("\\.ss" . scheme-mode) auto-mode-alist))

(require 'geiser)
(require 'quack)

(defun self/scheme-mode-hook ()
  "Cusomizations of scheme mode"
  (smartparens-mode)
  (rainbow-delimiters-mode)

  ;; Updating custom faces in scheme mode
  (custom-set-faces
   '(quack-pltish-comment-face ((t (:foreground "#aeaeae"))))
   '(quack-pltish-defn-face ((t (:foreground "#dfaf8f"))))))

(add-hook 'scheme-mode-hook 'self/scheme-mode-hook)
