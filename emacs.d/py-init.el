;; Python Hook

(setq python-indent 4)

(defun projectile-pyenv-mode-set ()
  "Set pyenv version matching project name.
  Version must be already installed."
  (pyenv-mode-set (projectile-project-name)))

(setq py-python-command "python3")
(setq python-shell-interpreter "ipython")
(setq elpy-rpc-python-command "python3")
(setq elpy-rpc-backend "jedi")

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

; use IPython
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt -i")

;; Remove autocomplete mode for python
;; (setq ac-modes (delq 'python-mode ac-modes))

(elpy-enable)

;; Remove flymake for python and use flycheck minor mode
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; (setq ein:use-auto-complete t)

;; Or, to enable "superpack" (a little bit hacky improvements):
;; (setq ein:use-auto-complete-superpack t)

(add-hook 'ein-mode 'smartparens-mode)

(eval-after-load 'elpy
  '(progn
     (define-key elpy-mode-map (kbd "C-c C-p") nil)))

(setq gud-pdb-command-name "python -m pdb")

;; (setq ein:use-smartrep t)

;; (pyvenv-activate (expand-file-name "~/installed.d/anaconda/envs/mlapp"))
(defun self/python-mode ()
  "Customizations for python mode"
  (setq indent-tabs-mode nil
        python-indent 4
        tab-width 4)
  (setenv "WORKON_HOME" "/usr/local/anaconda3/envs")
  (pyvenv-mode 1)
  (eldoc-mode 1)
  (smartparens-mode 1)
  (yafolding-mode 1)
  (yas-minor-mode 1)
  (highlight-indentation-mode 1))

(add-hook 'python-mode-hook 'self/python-mode)

;; (add-hook 'python-mode-hook 'anaconda-mode)
;; (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
