;; Python Hook
(defun self/python-mode ()
  "Customizations for python mode"
  (setq indent-tabs-mode nil
        python-indent 4
        tab-width 4)
  (pyvenv-mode 1)
  (eldoc-mode 1)
  (smartparens-mode 1)
  (yafolding-mode 1)
  (yas-minor-mode 1)
  (highlight-indentation-mode 1)
  (pyvenv-activate "/usr/local/anaconda3/envs/PDSH"))

(defun self/inf-python-mode ()
  "Customizations for inf python mode"
  ;; (eldoc-mode 1)    ;; eldoc mode does not work in inf-python buffer
  (smartparens-mode 1)
  (highlight-indentation-mode 1))

(defun projectile-pyenv-mode-set ()
  "Set pyenv version matching project name.
  Version must be already installed."
  (pyenv-mode-set (projectile-project-name)))

(require 'python)
;; TODO: Move this to eval-after-load python
(add-to-list 'python-shell-completion-native-disabled-interpreters "jupyter")

(setenv "WORKON_HOME" "/usr/local/anaconda3/envs")

; use IPython
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")

;; Reference :: https://elpy.readthedocs.io/en/latest/ide.html#interpreter-setup
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil
      ;; python is aliased to use python3
      py-python-command "python3"
      ;; use the wx backend, for both mayavi and matplotlib
      py-python-command-args '("--gui=wx" "--pylab=wx" "-colors" "Linux")
      py-force-py-shell-name-p t
      ;; switch to the interpreter after executing code
      py-shell-switch-buffers-on-execute-p t
      py-switch-buffers-on-execute-p t
      ;; don't split windows
      py-split-windows-on-execute-p nil
      ;; try to automagically figure out indentation
      py-smart-indentation t)

(setq elpy-rpc-python-command "python3"
      elpy-rpc-backend "jedi")

;; using highlight-indentation mode
(require 'highlight-indentation)
(setq highlight-indentation-blank-lines t)

;; The following setting works for leuven-theme
;; (set-face-background 'highlight-indentation-face "#eeeeee")
;; (set-face-background 'highlight-indentation-current-column-face "#eeeeee")

;; Remove autocomplete mode for python
;; (setq ac-modes (delq 'python-mode ac-modes))

(elpy-enable)

;; Remove flymake for python and use flycheck minor mode
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(eval-after-load 'elpy
  '(progn
     (define-key elpy-mode-map (kbd "C-c C-p") nil)))

;; (setq ein:use-auto-complete t)

;; Or, to enable "superpack" (a little bit hacky improvements):
;; (setq ein:use-auto-complete-superpack t)

(add-hook 'ein-mode 'smartparens-mode)

(setq gud-pdb-command-name "python -m pdb")

;; (setq ein:use-smartrep t)

;; (pyvenv-activate (expand-file-name "~/installed.d/anaconda/envs/mlapp"))
(add-hook 'python-mode-hook 'self/python-mode)
(add-hook 'inferior-python-mode-hook 'self/inf-python-mode)

;; (add-hook 'python-mode-hook 'anaconda-mode)
;; (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
