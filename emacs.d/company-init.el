(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (global-company-mode t))

(defun company-yasnippet-or-completion ()
  "Solve company yasnippet conflicts."
  (interactive)
  (let ((yas-fallback-behavior
         (apply 'company-complete-common nil)))
    (yas-expand)))

(defun my/company-mode-hook ()
  "Customisations for company-mode"
  (substitute-key-definition
   'company-complete-common
   'company-yasnippet-or-completion
   company-active-map))

(add-hook 'company-mode-hook 'my/company-mode-hook)

;; (use-package company-irony
;;   :ensure t
;;   :config
;;   (add-to-list 'company-backends 'company-irony))

;; (use-package irony
;;   :ensure t
;;   :config
;;   (add-hook 'c++-mode-hook 'irony-mode)
;;   (add-hook 'c-mode-hook 'irony-mode)
;;   (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

;; (use-package irony-eldoc
;;   :ensure t
;;   :config
;;   (add-hook 'irony-mode-hook #'irony-eldoc))

;; (use-package company-jedi
;;   :ensure t
;;   :config
;;   (add-hook 'python-mode-hook 'jedi:setup))

;; (defun my/python-mode-hook ()
;;   (add-to-list 'company-backends 'company-jedi))

;; (add-hook 'python-mode-hook 'my/python-mode-hook)

;; company box mode
;; (use-package company-box
;;   :ensure t
;;   :hook (company-mode . company-box-mode))
