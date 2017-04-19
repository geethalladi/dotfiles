;; Python Hook

(add-hook 'python-mode-hook
 (function (lambda ()
             (setq indent-tabs-mode nil
                   python-indent 4
                   tab-width 4))))
(setq python-indent 4)

(defun projectile-pyenv-mode-set ()
  "Set pyenv version matching project name.
  Version must be already installed."
  (pyenv-mode-set (projectile-project-name)))

; use the wx backend, for both mayavi and matplotlib
(setq py-python-command-args
  '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
(setq py-force-py-shell-name-p t)

; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
; don't split windows
(setq py-split-windows-on-execute-p nil)
; try to automagically figure out indentation
(setq py-smart-indentation t)

; use IPython
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt -i")

;; Remove autocomplete mode for python
(setq ac-modes (delq 'python-mode ac-modes))

(elpy-enable)
(add-hook 'python-mode-hook 'eldoc-mode)
(add-hook 'python-mode-hook 'smartparens-mode)
(add-hook 'python-mode-hook 'yafolding-mode)
(add-hook 'python-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'yas-minor-mode)

;; (add-hook 'python-mode-hook 'anaconda-mode)
;; (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
