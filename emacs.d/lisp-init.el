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
  (require 'rainbow-delimiters)
  (rainbow-delimiters-mode)
  (require 'hungry-delete)
  (hungry-delete-mode)
  (require 'eldoc)
  (eldoc-mode)
  (self/configure-prettify-symbols-alist))

(defun self/elisp-customizations ()
  "Customizations for emacs lisp mode"
  (self/lisp-customizations)
  (turn-on-elisp-slime-nav-mode))


(defun self/lisp-interaction-customizations ()
  "Customizations of lisp interaction mode"
  (message "Calling Lisp Interaction Customizations")
  (self/lisp-customizations)
  ;; disable litable mode
  ;; as scratch buffer mostly is devoid of lisp code
  ;; (litable-mode)
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
  (setq scheme-program-name "racket")
  (setq geiser-scheme-implementation 'racket)
  (geiser-mode))

(defun self/hy-lang-mode ()
  "Customizations for hy-lang"
  (self/lisp-customizations))

;; (load (expand-file-name "~/installed.d/quicklisp/slime-helper.el"))

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

(setq geiser-chez-binary "/usr/local/bin/chez")

(custom-set-variables '(scheme-program-name "chez"))

(setq scheme-program-name "chez")

;; (setq geiser-active-implementations '(chez))

;; (setq geiser-default-implementation 'chez)

(setq geiser-implementations-alist
      '(((regexp "\\.scm$") chez)
        ((regexp "\\.ss$") chez)
        ((regexp "\\.rkt$") racket)))

;; Disable version check
(setq geiser-repl-skip-version-check-p 't)


(require 'geiser)
(require 'quack)

(add-hook 'scheme-mode-hook 'self/lisp-customizations)
(add-hook 'emacs-lisp-mode-hook 'self/lisp-customizations)
(add-hook 'lisp-interaction-mode-hook 'self/lisp-interaction-customizations)
(add-hook 'racket-mode-hook 'self/racket-mode)

(add-hook 'hy-mode-hook 'self/hy-lang-mode)

(add-to-list 'auto-mode-alist '("\\.scm$" . scheme-mode))
(add-to-list 'auto-mode-alist '("\\.ss$" . scheme-mode))
(add-to-list 'auto-mode-alist '("\\.rkt$" . racket-mode))
