(use-package projectile)
(use-package flycheck)
(use-package yasnippet :config (yas-global-mode))
(use-package lsp-mode :hook ((lsp-mode . lsp-enable-which-key-integration)))
(use-package hydra)
(use-package company)
;; (use-package lsp-ui)
(use-package which-key :config (which-key-mode))
(use-package lsp-java :config (add-hook 'java-mode-hook 'lsp))
(use-package dap-mode :after lsp-mode :config (dap-auto-configure-mode))
(use-package dap-java :ensure nil)
(use-package helm-lsp)
(use-package helm
       :config (helm-mode))
(use-package lsp-treemacs)

;; (setq lsp-java-jdt-download-url
;;       "https://download.eclipse.org/jdtls/milestones/0.57.0/jdt-language-server-0.57.0-202006172108.tar.gz")

;; (setq lsp-java-vmargs
;;       '("-noverify" "-Xmx3G" "-XX:+UseG1GC" "-XX:+UseStringDeduplication"
;;         "-javaagent:/Users/galladi/.m2/repository/org/projectlombok/lombok/1.18.20/lombok-1.18.20.jar"
;;         "-Xbootclasspath/a:/Users/galladi/.m2/repository/org/projectlombok/lombok/1.18.20/lombok-1.18.20.jar"))

;; (use-package lsp-sonarlint)
;; (use-package lsp-sonarlint-java)
;; (setq lsp-sonarlint-java-enabled t)

(defun self/java-mode ()
  "Java mode customizations"
  (setq c-basic-offset 2)
  (smartparens-mode 1)
  ;; (lsp-sonarlint-java)
  (setq line-spacing 0.2))

(add-hook 'java-mode-hook 'self/java-mode)
