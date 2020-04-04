;; Loading my customizations
;; Start the emacs-server
(load "~/.emacs.d/emacs-server.el")

(load "~/.emacs.d/clipboard.el")

(load "~/.emacs.d/theme-init.el")

(defun self/load-all ()
  "Load the entire environment"
  (interactive)
  (self/load-dev-env)
  (self/load-org-env))

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
  (load "~/.emacs.d/other-modes-init.el"))
