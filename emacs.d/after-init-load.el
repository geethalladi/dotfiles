(defun self/load-all ()
  "Load the entire environment"
  (interactive)
  (self/load-packages)
  (self/load-dev-env)
  (self/load-org-env))

(defun self/load-packages ()
  "Loads all the installed packages"

  ;; PACKAGE ARCHIVE
  (setq package-archives
  '(("gnu" . "http://elpa.gnu.org/packages/")
    ("marmalade" . "https://marmalade-repo.org/packages/")
    ("melpa" . "http://melpa.milkbox.net/packages/")))

  ;; Org-mode's repository
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

  ;; ENABLE CASK
  (require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
  ;; (require 'cask "~/.emacs.d/.cask/26.1/elpa/cask-20180626.1949/cask.el")
  (cask-initialize)
  ;; Setting the location of the cask file
  (setq cask-filename "~/.emacs.d/Cask")

  ;; ENABLE PALLET
  (require 'pallet)
  (pallet-mode t)

  ;; Load vendor el files
  (add-to-list 'load-path "~/dotfiles/emacs.d/vendor")

  ;; emacs getting the same path when invoked from GUI
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize))

  ;; ENABLE PERSISTENT SCRATCH
  (persistent-scratch-setup-default)
  (persistent-scratch-autosave-mode 1)

  (load "~/.emacs.d/clipboard.el"))

(defun self/load-org-env ()
  "Load the org environment"

  (load "~/.emacs.d/org-mode-init.el")
  (load "~/.emacs.d/org-agenda-init.el")
  (load "~/.emacs.d/org-capture-init.el")
  (load "~/.emacs.d/org-babel-init.el"))

(defun self/load-dev-env ()
  "Load the development environment"

  (load "~/.emacs.d/helm-init.el")
  (load "~/.emacs.d/keychord-init.el")
  (load "~/.emacs.d/vendor/help-fns+.el")

  (load "~/.emacs.d/smartparens.el")
  (load "~/.emacs.d/company-init.el")
  (load "~/.emacs.d/projectile-init.el")

  ;; (load "~/.emacs.d/term.el")
  (load "~/.emacs.d/multi-term.el")

  (load "~/.emacs.d/py-init.el")
  (load "~/.emacs.d/rb-init.el")
  (load "~/.emacs.d/haskell-init.el")
  (load "~/.emacs.d/erlang-init.el")

  ;; Loading js init script
  (load "~/.emacs.d/js-init.el")
  (load "~/.emacs.d/ts-init.el")
  (load "~/.emacs.d/web-init.el")

  ;; (load "~/.emacs.d/elixir-init.el")
  ;; (load "~/.emacs.d/scala-init.el")
  ;; (load "~/.emacs.d/go-init.el")

  (load "~/.emacs.d/clojure-init.el")
  (load "~/.emacs.d/lisp-init.el")
  (load "~/.emacs.d/emacs-lisp-init.el")

  (load "~/.emacs.d/tramp-init.el")
  (load "~/.emacs.d/yas-init.el")
  (load "~/.emacs.d/pdf-init.el")
  (load "~/.emacs.d/epub-init.el")

  (load "~/.emacs.d/custom.el")
  (load "~/.emacs.d/theme-init.el")
  (load "~/.emacs.d/other-modes-init.el"))
