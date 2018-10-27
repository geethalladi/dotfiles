(require 'rainbow-delimiters)
(require 'icomplete)

(show-paren-mode 1)
(add-to-list 'same-window-buffer-names "<em>nrepl</em>")

(setq nrepl-log-messages t)
(setq nrepl-buffer-name-separator "-")
(setq nrepl-popup-stacktraces nil)

(add-hook 'cider-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-mode-hook 'paredit-mode)
(add-hook 'cider-mode-hook #'company-mode)

(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-repl-mode-hook '(lambda () (linum-mode 0)))

(add-hook 'clojure-mode-hook #'paredit-mode)
(add-hook 'clojure-mode-hook #'subword-mode)
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook #'turn-on-eldoc-mode)

;; (cider-jack-in)
