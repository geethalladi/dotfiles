(defun self/java-mode ()
  "Java mode customizations"
  (setq line-spacing 0.2))

(add-hook 'java-mode-hook 'self/java-mode)

;; (condition-case nil
;;     (require 'use-package)
;;   (file-error
;;    (require 'package)
;;    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;;    (package-initialize)
;;    (package-refresh-contents)
;;    (package-install 'use-package)
;;    (setq use-package-always-ensure t)
;;    (require 'use-package)))

;; (use-package projectile)
;; (use-package flycheck)
;; (use-package yasnippet :config (yas-global-mode))
;; (use-package lsp-mode :hook ((lsp-mode . lsp-enable-which-key-integration)))
;; (use-package hydra)
;; (use-package company)
;; (use-package lsp-ui)
;; (use-package which-key :config (which-key-mode))
;; (use-package lsp-java :config (add-hook 'java-mode-hook 'lsp))

;; (require 'dap-mouse)
;; (require 'dap-java)
;; (require 'lsp-modeline)
;; (use-package dap-mode :after lsp-mode :config (dap-auto-configure-mode))
;; (dap-mode 1)
;; (dap-tooltip-mode 1)
;; (require 'dap-ui)

;; (use-package dap-java :ensure nil)
;; (use-package helm-lsp)
;; (use-package helm
;;   :config (helm-mode))
;; (use-package lsp-treemacs)
