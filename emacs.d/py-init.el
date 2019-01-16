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

(setq py-python-command "python3")
(setq python-shell-interpreter "ipython")

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

;; using highlight-indentation mode

(require 'highlight-indentation)
(setq highlight-indentation-blank-lines t)

;; The following setting works for leuven-theme
;; (set-face-background 'highlight-indentation-face "#eeeeee")
;; (set-face-background 'highlight-indentation-current-column-face "#eeeeee")

;; The following setting works for heroku theme
(set-face-background 'highlight-indentation-face "#3B4242")
(set-face-background 'highlight-indentation-current-column-face "#3B4242")

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
(add-hook 'python-mode-hook 'highlight-indentation-mode)

;; (add-hook 'python-mode-hook 'anaconda-mode)
;; (add-hook 'python-mode-hook 'anaconda-eldoc-mode)

(setq ein:use-auto-complete t)

;; Or, to enable "superpack" (a little bit hacky improvements):
(setq ein:use-auto-complete-superpack t)
(add-hook 'ein-mode 'smartparens-mode)

;; (setq ein:use-smartrep t)

;; (pyvenv-activate (expand-file-name "~/installed.d/anaconda/envs/mlapp"))

(setq elpy-rpc-backend "jedi")
