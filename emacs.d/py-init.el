;; Python Hook

(add-hook 'python-mode-hook
 (function (lambda ()
             (setq indent-tabs-mode nil
                   python-indent 4
                   tab-width 4))))
(setq python-indent 4)

(elpy-enable)
(add-hook 'python-mode-hook 'eldoc-mode)
(add-hook 'python-mode-hook 'smartparens-mode)
(add-hook 'python-mode-hook 'yafolding-mode)
(add-hook 'python-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'yas-minor-mode)

;; (add-hook 'python-mode-hook 'anaconda-mode)
;; (add-hook 'python-mode-hook 'anaconda-eldoc-mode)

(defun projectile-pyenv-mode-set ()
  "Set pyenv version matching project name.
  Version must be already installed."
  (pyenv-mode-set (projectile-project-name)))
