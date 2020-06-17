(defun self/configure-prettify-symbols-alist ()
  "Set prettify symbols alist."
  (setq prettify-symbols-alist
        '(("lambda" . ?λ)
          ;; ("=<<" . ?=≪)  ;; ? is always followed by a single character
          ;; (">>=" . ?≫=)
          ;; ("map" . ?↦)
          ("->" . ?→)
          ("->>" . ?↠)
          ("=>" . ?⇒)
          ("/=" . ?≠)
          ("!=" . ?≠)
          ("==" . ?≡)
          ("<=" . ?≤)
          (">=" . ?≥)
          ("<=<" . ?↢)
          (">=>" . ?↣)
          ("&&" . ?∧)
          ("||" . ?∨)
          ("not" . ?¬))))

(defun self/lisp-customizations ()
  "Customizations of lisp mode"
  (yafolding-mode)
  (smartparens-mode)
  (rainbow-delimiters-mode)
  (hungry-delete-mode)
  (eldoc-mode)
  (self/configure-prettify-symbols-alist))

(defun self/lisp-interaction-customizations ()
  "Customizations of lisp interaction mode"
  (message "Calling Lisp Interaction Customizations")
  (self/lisp-customizations)
  (litable-mode)
  ;; specific for scratch buffer
  (when (string-equal (buffer-name) "*scratch*")
    ;; disable hungry delete mode
    (hungry-delete-mode -1)
    ;; enable flyspell minor mode
    (flyspell-mode 1)
    ;; enable visual-line-mode
    (visual-line-mode 1)))

(defun self/racket-mode ()
  "Customizations of racket mode"
  (self/lisp-customizations)
  (geiser-mode))

(load (expand-file-name "~/installed.d/quicklisp/slime-helper.el"))
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

;; (setq geiser-active-implementations '(chez))

;; (setq geiser-default-implementation 'chez)

(setq geiser-implementations-alist
      '(((regexp "\\.scm$") chez)
        ((regexp "\\.ss$") chez)
        ((regexp "\\.rkt$") racket)))

;; Disable version check
(setq geiser-repl-skip-version-check-p 't)

(setq geiser-chez-binary "/usr/local/bin/chez")

(require 'geiser)
(require 'quack)

(add-hook 'scheme-mode-hook 'self/lisp-customizations)
(add-hook 'emacs-lisp-mode-hook 'self/lisp-customizations)
(add-hook 'lisp-interaction-mode-hook 'self/lisp-interaction-customizations)
(add-hook 'racket-mode-hook 'self/racket-mode)

(add-to-list 'auto-mode-alist '("\\.scm$" . scheme-mode))
(add-to-list 'auto-mode-alist '("\\.ss$" . scheme-mode))
(add-to-list 'auto-mode-alist '("\\.rkt$" . racket-mode))
