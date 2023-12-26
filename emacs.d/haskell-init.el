(use-package haskell-mode)
(use-package haskell-emacs)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;; (add-hook 'haskell-mode-hook 'structured-haskell-mode)

(add-hook 'haskell-mode-hook 'smartparens-mode)
