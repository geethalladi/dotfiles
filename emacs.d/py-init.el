;; python mode hook
(use-package elpy)

(defun self/-python-mode-custom-keybindings ()
  "Customizing python mode keybindings"

  ;; new keybindings for elpy mode
  ;; Instead of region, currently use staement, for faster iteration
  (define-key elpy-mode-map (kbd "C-c C-c") 'elpy-shell-send-statement-and-go)
  (define-key elpy-mode-map (kbd "s-<down>") 'elpy-nav-forward-block)
  (define-key elpy-mode-map (kbd "s-<up>") 'elpy-nav-backward-block)

  ;; Removing conflicting keys from smartparens minor-mode
  ;; when used as a minor mode in elpy
  (let ((oldmap (cdr (assoc 'smartparens-mode minor-mode-map-alist)))
        (newmap (make-sparse-keymap)))
    (set-keymap-parent newmap oldmap)
    (define-key newmap (kbd "s-<down>") nil)
    (define-key newmap (kbd "s-<up>") nil)
    (make-local-variable 'minor-mode-overriding-map-alist)
    (push `(smartparens-mode . ,newmap) minor-mode-overriding-map-alist)))

(defun self/python-mode ()
  "Customizations for python mode"
  (message "Python mode customizations")
  (setq indent-tabs-mode nil
        python-indent 4
        tab-width 4
        elpy-test-pytest-runner-command '("py.test")
        py-autopep8-options '("--max-line-length=88")
        elpy-formatter "black"
        ;; Don't resize the existing window heights
        even-window-heights nil)

  (self/-python-mode-custom-keybindings)

  (pyvenv-mode 1)
  ;; (pipenv-mode 1)
  (eldoc-mode 1)
  (smartparens-mode 1)
  (yafolding-mode 1)
  (yas-minor-mode 1)
  (py-autopep8-mode 1)
  (highlight-indentation-mode 1)
  (self/-use-ipython)
  (elpy-set-test-runner 'elpy-test-pytest-runner))

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

(setenv "WORKON_HOME" ".")

(defun self/-use-ipython ()
  "Using ipython as the default interpreter"
  ;; use IPython
  ;; TODO: Move this to eval-after-load python
  (add-to-list 'python-shell-completion-native-disabled-interpreters "jupyter")

  ;; Reference :: https://elpy.readthedocs.io/en/latest/ide.html#interpreter-setup
  (setq python-shell-interpreter "ipython"
        py-shell-name "ipython"
        py-which-bufname "IPython"
        python-shell-interpreter-args "-i --simple-prompt"
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
        py-smart-indentation t))

(defun self/-use-python ()
  "Use regular python for inf-python"
  (setq python-shell-interpreter "python"
        python-shell-interpreter-args "-i"
        python-shell-completion-native-enable nil
        ;; switch to the interpreter after executing code
        py-shell-switch-buffers-on-execute-p t
        py-switch-buffers-on-execute-p t))

;; using highlight-indentation mode
(require 'highlight-indentation)
(setq highlight-indentation-blank-lines t)

;; The following setting works for leuven-theme
;; (set-face-background 'highlight-indentation-face "#eeeeee")
;; (set-face-background 'highlight-indentation-current-column-face "#eeeeee")

;; Remove autocomplete mode for python
;; (setq ac-modes (delq 'python-mode ac-modes))

(defun self/-elpy-configure ()
  (setq elpy-rpc-python-command "python3"
        elpy-rpc-backend "jedi"
        elpy-rpc-virtualenv-path 'current
        ;; stops throwing Ctrl-G when the file is fully loaded
        elpy-shell-echo-output nil)

  ;; Remove flymake for python and use flycheck minor mode
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))

  ;; (require 'py-autopep8)
  ;; (py-autopep8-enable-on-save)
  (eval-after-load 'elpy
    '(progn
       (define-key elpy-mode-map (kbd "C-c C-p") nil))))

;; (setq ein:use-auto-complete t)

;; Or, to enable "superpack" (a little bit hacky improvements):
;; (setq ein:use-auto-complete-superpack t)

(add-hook 'ein-mode 'smartparens-mode)

(setq gud-pdb-command-name "python -m pdb")

;; (setq ein:use-smartrep t)

;; (pyvenv-activate (expand-file-name "~/installed.d/anaconda/envs/mlapp"))
(add-hook 'python-mode-hook 'self/python-mode)
(add-hook 'inferior-python-mode-hook 'self/inf-python-mode)

(add-hook 'elpy-mode-hook 'self/-elpy-configure)

(require 'elpy)
(elpy-enable)
(require 'py-autopep8)

;; (add-hook 'python-mode-hook 'anaconda-mode)
;; (add-hook 'python-mode-hook 'anaconda-eldoc-mode)

;; customizations for inf-python mode

(defun self/-pyrepl-output-start ()
  "Get the starting position of the last REPL output"
  (save-excursion
    (search-backward "Out[")
    (next-line)
    (beginning-of-line)
    (point)))

(defun self/-pyrepl-output-end ()
  "Get the end position of the last REPL output"
  (save-excursion
    (previous-line)
    (point)))

(defun self/extract-repl-output-into-buffer ()
  "Extract the last REPL output into a separate buffer"
  (interactive)
  (let* ((start (self/-pyrepl-output-start))
         (end (self/-pyrepl-output-end))
         (buffer (get-buffer-create "*Python-Output*"))
         (contents (buffer-substring-no-properties start end)))
    (with-current-buffer buffer
      (switch-to-buffer buffer)
      (erase-buffer)
      (insert contents)
      (python-mode))))

(define-key inferior-python-mode-map (kbd "C-c p")
  'self/extract-repl-output-into-buffer)
