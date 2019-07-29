;; Customizations for emacs lisp mode

(defun self/emacs-lisp-mode ()
  "Customisation of emacs lisp mode"
  (smartparens-mode)
  (rainbow-delimiters-mode))

(add-hook 'emacs-lisp-mode-hook 'self/emacs-lisp-mode)

(defun self/lisp-interaction-mode ()
  "Customizations of Lisp Interaction mode"
  (smartparens-mode)
  (rainbow-delimiters-mode))

(add-hook 'lisp-interaction-mode-hook 'self/lisp-interaction-mode)
