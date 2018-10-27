(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)

(setq nrepl-popup-stacktraces nil)

(add-to-list 'same-window-buffer-names "<em>nrepl</em>")

;; Popping up contextual menu
(eval-after-load "cider"
  '(define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc))

(add-hook 'cider-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

(show-paren-mode 1)

(require 'rainbow-delimiters)
(add-hook 'cider-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

(setq nrepl-log-messages t)
(setq nrepl-buffer-name-separator "-")

(require 'icomplete)
(add-hook 'cider-mode-hook #'company-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)

(add-hook 'cider-repl-mode-hook '(lambda () (linum-mode 0)))

(add-hook 'clojure-mode-hook #'paredit-mode)
(add-hook 'clojure-mode-hook #'subword-mode)
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)

;; (cider-jack-in)
