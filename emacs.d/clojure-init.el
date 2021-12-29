(require 'clojure-mode)

(defun self/-clojure-mode ()
  "Clojure mode customization"
  (show-paren-mode 1)
  (smartparens-mode)
  (yafolding-mode)
  (paxedit-mode)
  (subword-mode)
  (turn-on-eldoc-mode)
  (rainbow-delimiters-mode)
  (rainbow-identifiers-mode)
  ;; (inf-clojure-minor-mode)

  ;; using function style indent for match / matche
  ;; '1' means the body comes after the first argument
  ;; https://github.com/clojure-emacs/clojure-mode/tree/5.3.0#indentation-of-macro-forms
  (define-clojure-indent
    (-> 1)
    (--> 1)
    (match 1)
    (matche 1))

  ;; Skip adding cider mode for now
  (self/-add-cider-mode)
  (hungry-delete-mode))

(add-hook 'clojure-mode-hook 'self/-clojure-mode)

(defun self/-add-cider-mode ()
  "Adding cider minor mode for clojure editing"

  ;; (add-to-list 'same-window-buffer-names "<em>nrepl</em>")

  (setq nrepl-log-messages t)
  (setq nrepl-buffer-name-separator "-")
  (setq nrepl-popup-stacktraces nil)

  ;; no longer prompt while asking for doc-at-point
  (setq cider-prompt-for-symbol nil)

  (add-hook 'cider-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'cider-mode-hook 'smartparens-mode)
  (add-hook 'cider-mode-hook #'company-mode)

  (add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'cider-repl-mode-hook 'smartparens-mode)
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-repl-mode-hook '(lambda () (linum-mode 0)))

  (define-key cider-mode-map (kbd "C-c C-d z") 'zeal-at-point)

  (add-hook 'clojure-mode-hook #'cider-mode))

;; TODO:
;; unbind C-c C-p p
;; C-x C-p to cider-pprint
;; C-x C-e to cider-eval (exists)
;; C-c C-d d to show the documentation (exists)
;; hydra for smartparens slurp / barp
