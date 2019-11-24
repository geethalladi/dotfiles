(require 'rainbow-delimiters)
(require 'icomplete)

(show-paren-mode 1)
(add-to-list 'same-window-buffer-names "<em>nrepl</em>")

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

;; Added cider mode for clojure editing
(add-hook 'clojure-mode-hook #'cider-mode)
(add-hook 'clojure-mode-hook #'smartparens-mode)
(add-hook 'clojure-mode-hook #'subword-mode)
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook #'turn-on-eldoc-mode)

;; TODO:
;; unbind C-c C-p p
;; C-x C-p to cider-pprint
;; C-x C-e to cider-eval (exists)
;; C-c C-d d to show the documentation (exists)
;; hydra for smartparens slurp / barp
