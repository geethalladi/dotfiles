;; (use-package ensime :pin melpa-stable)
;; (add-to-list exec-path "/usr/local/bin")

(add-to-list 'auto-mode-alist '("\\.scala" . scala-mode))

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
