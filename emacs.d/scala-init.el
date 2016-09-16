;; (use-package ensime :pin melpa-stable)
;; (add-to-list exec-path "/usr/local/bin")

(add-to-list 'auto-mode-alist '("\\.sc" . scala-mode))
(add-to-list 'auto-mode-alist '("\\.scala" . scala-mode))

(setq scala-indent:align-parameters t)

(require 'ensime)
(require 'smartparens)
(require 'yafolding)

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(add-hook 'scala-mode-hook 'smartparens-mode)
(add-hook 'scala-mode-hook 'yafolding-mode)
