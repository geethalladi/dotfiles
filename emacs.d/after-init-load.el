(defun self/-reload-scratch-buffer ()
  "reload scratch buffer for modes to take effect"
  (let* ((buffer-name "*scratch*")
         (filter-scratch-p (lambda (buf) (string-prefix-p buffer-name (buffer-name buf))))
         (scratch-buffer
          (elt (seq-filter filter-scratch-p (buffer-list)) 0)))
    (with-current-buffer scratch-buffer
      (lisp-interaction-mode))))

(defun self/load-all ()
  "Load the entire environment"
  (interactive)
  ;; load details about the installed packages
  (self/load-packages)
  ;; load customizations of these packages
  (self/load-customizations)
  ;; load the development environment
  (self/load-dev-env)
  ;; load org mode customizations
  (self/load-org-env)
  ;; load my own lisp extensions
  (self/load-self-lisp)
  ;; clean up modal line
  (self/-diminish-modal-line)
  ;; reload scratch-buffer after loading everything
  (self/-reload-scratch-buffer))

(defun self/load-customizations ()
  "Customize the installed packages"

  ;; emacs getting the same path when invoked from GUI
  ;; (when (memq window-system '(mac ns))
  ;;   (exec-path-from-shell-initialize))

  ;; ENABLE PERSISTENT SCRATCH
  (require 'persistent-scratch)
  (persistent-scratch-setup-default)
  ;; (persistent-scratch-autosave-mode 1)

  (load (expand-file-name "helm-init.el" user-emacs-directory))
  (load (expand-file-name "keychord-init.el" user-emacs-directory))
  (load (expand-file-name "vendor/help-fns+.el" user-emacs-directory))
  (load (expand-file-name "vendor/tiddlywiki-mode.el" user-emacs-directory))

  (load (expand-file-name "clipboard.el" user-emacs-directory))

  (load (expand-file-name "tramp-init.el" user-emacs-directory))
  (load (expand-file-name "yas-init.el" user-emacs-directory))
  (load (expand-file-name "tex-init.el" user-emacs-directory))
  (load (expand-file-name "pdf-init.el" user-emacs-directory))
  (load (expand-file-name "epub-init.el" user-emacs-directory))

  (load (expand-file-name "custom.el" user-emacs-directory))
  (load (expand-file-name "terminal-key-decode.el" user-emacs-directory))
  (load (expand-file-name "theme-init.el" user-emacs-directory))
  (load (expand-file-name "tamil-font.el" user-emacs-directory)))

(defun self/-diminish-modal-line ()
  "Remove the most used packages from the modal line"

  (require 'diminish)
  ;; Hide from appearing as sub-modes
  (diminish 'google-this-mode)
  (diminish 'helm-mode)
  (diminish 'projectile-mode)
  (diminish 'flyspell-mode)
  (diminish 'smartparens-mode)
  (diminish 'highlight-indentation-mode)
  (diminish 'osx-clipboard-mode)
  (diminish 'editorconfig-mode))

(defun self/load-packages ()
  "Loads all the installed packages"

  ;; PACKAGE ARCHIVE
  (setq package-archives
  '(("gnu" . "http://elpa.gnu.org/packages/")
    ;; ("marmalade" . "https://marmalade-repo.org/packages/")
    ("melpa" . "http://melpa.org/packages/")))

  ;; Org-mode's repository
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

  ;; ENABLE CASK
  (require 'cask)
  ;; (require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
  ;; (require 'cask
  ;;   (expand-file-name ".cask/26.1/elpa/cask-20180626.1949/cask.el" user-emacs-directory))
  (cask-initialize)
  ;; Setting the location of the cask file
  (setq cask-filename (expand-file-name "Cask" user-emacs-directory))

  ;; ENABLE PALLET
  (require 'pallet)
  (pallet-mode t)
  (require 'use-package)

  ;; Load vendor el files
  (add-to-list 'load-path (expand-file-name "vendor" user-emacs-directory)))

(defun self/load-org-env ()
  "Load the org environment"

  (load (expand-file-name "org-mode-init.el" user-emacs-directory))
  (load (expand-file-name "org-agenda-init.el" user-emacs-directory))
  (load (expand-file-name "org-capture-init.el" user-emacs-directory))
  (load (expand-file-name "org-babel-init.el" user-emacs-directory))
  (load (expand-file-name "vendor/org-colored-text.el" user-emacs-directory)))

(defun self/load-dev-env ()
  "Load the development environment"

  (load (expand-file-name "smartparens.el" user-emacs-directory))

  ;; (load (expand-file-name "term.el" user-emacs-directory))
  (load (expand-file-name "multi-term.el" user-emacs-directory))

  (load (expand-file-name "py-init.el" user-emacs-directory))
  (load (expand-file-name "rb-init.el" user-emacs-directory))
  ;; (load (expand-file-name "haskell-init.el" user-emacs-directory))
  (load (expand-file-name "ocaml-init.el" user-emacs-directory))
  ;; (load (expand-file-name "erlang-init.el" user-emacs-directory))
  (load (expand-file-name "prolog-init.el" user-emacs-directory))

  (load (expand-file-name "company-init.el" user-emacs-directory))
  (load (expand-file-name "projectile-init.el" user-emacs-directory))

  ;; Loading js init script
  (load (expand-file-name "js-init.el" user-emacs-directory))
  (load (expand-file-name "ts-init.el" user-emacs-directory))
  (load (expand-file-name "web-init.el" user-emacs-directory))

  ;; (load (expand-file-name "elixir-init.el" user-emacs-directory))
  ;; (load (expand-file-name "scala-init.el" user-emacs-directory))
  (load (expand-file-name "go-init.el" user-emacs-directory))
  (load (expand-file-name "c-init.el" user-emacs-directory))

  (load (expand-file-name "clojure-init.el" user-emacs-directory))
  (load (expand-file-name "lisp-init.el" user-emacs-directory))

  (load (expand-file-name "other-modes-init.el" user-emacs-directory))
  (load (expand-file-name "log-init.el" user-emacs-directory))

  ;; Loading font ligatures for development
  (load (expand-file-name "font-ligatures.el" user-emacs-directory)))

(defun self/load-self-lisp ()
  "Load my personal lisp extensions"

  ;; to facilitate the velocity of lectures
  (load (expand-file-name "self-lisp/lecture-stats.el" user-emacs-directory))
  (load (expand-file-name "self-lisp/index.el" user-emacs-directory))
  ;; dayjob customizations
  (load (expand-file-name "self-lisp/dayjob.el" user-emacs-directory)))

;; (self/load-all)
