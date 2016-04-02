;; ENABLE CASK
(require 'cask "~/.emacs.d/.cask/24.5.1/elpa/cask-20150528.752/cask.el")
(cask-initialize)

;; ENABLE PALLET
(require 'pallet)
(pallet-mode t)

;; DIRTREE MODE
;; (require 'dirtree) ;; FOR OPTIMIZATION
(require 'neotree)

;; HELM MODE
(require 'helm)
(require 'helm-config)

;; Smartparens mode
(require 'smartparens)
(show-paren-mode t)

;; magit for GIT
(require 'magit)

(require 'ido)
(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)

;; etags table
;; (require 'etags-table)
;; (require 'etags-select)

;; load the pbcopy.el file for integrating terminal emacs with clipboard
(load "~/.emacs.d/pbcopy.el")
(require 'pbcopy)
(turn-on-pbcopy)

;; FOR OPTIMIZATION
;; (setenv "TMPDIR" "/var/tmp") ;; TMPDIR to be used by tramp-mode
;; (eval-after-load 'tramp
;;   '(vagrant-tramp-enable))
;; (require 'tramp)

(load "~/.emacs.d/multi-term.el")

;; autocompletion in M-x
(require 'smex)
(global-set-key (kbd "M-x") 'smex)

;;;; ENABLING THE MOST USED MODES BY DEFAULT

;; AUTO COMPLETE
(require 'auto-complete-config)
(ac-config-default)
;; [TODO] Update the exact path of the dictinoary
(add-to-list 'ac-dictionary-directories "~/.emacs.d/.cask/24.5.1/elpa/auto-complete-20150618.1949/dict")

(global-linum-mode 1)
(setq linum-format "%4d ")

; emacs getting the same path when invoked from GUI
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Use coreutils ls for dired program
(setq insert-directory-program (executable-find "gls"))

;; FOR OPTIMIZATION
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;; NO LONGER USING TAGS
;; (defun create-tags (dir-name)
;;   "Create tags file."
;;   (interactive "DDirectory: ")
;;   (shell-command
;;    (format "%s -f %s -e -R %s" path-to-ctags "TAGS" (directory-file-name dir-name))))

;; (setq tag-table-alist
;;       '(("~/.emacs.d" . "~/.emacs.d/TAGS")))
;; (setq etags-table-search-up 10)


;; FOR OPTIMIZATION
;; ;; Python Hook for tab spaces
;; (add-hook 'python-mode-hook
;;           (function (lambda ()
;;                       (setq indent-tabs-mode nil
;;                             tab-width 2))))

;; Projectile
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'helm)

(helm-projectile-on)
(setq helm-mode-fuzzy-match t)

;; TAB
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq standard-indent 2)
(setq c-basic-indent 2)
(setq tab-width 2)

;; (setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)
;; (highlight-tabs)
;; (highlight-trailing-whitespace)

;; wind move is moving through multiple windows(panes)
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; FOR OPTIMIZATION
;; ;; Dash at point for emacs
;; (require 'dash-at-point)
;; (autoload 'dash-at-point "dash-at-point"
;;     "Search the word at point with Dash." t nil)
;; (global-set-key "\C-cd" 'dash-at-point)
;; (global-set-key "\C-ce" 'dash-at-point-with-docset)

;; ENABLE PERSISTENT SCRATCH
(persistent-scratch-setup-default)
(persistent-scratch-autosave-mode 1)

;; delete trailing white space
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Load org-mode extensions
(load "~/.emacs.d/org-mode-init.el")

;; FOR OPTIMIZATION
;; ;; LISP
;; (setq inferior-lisp-program "/usr/local/bin/sbcl")
;; (load "~/.emacs.d/lisp-init.el")

;; ;; SASS
;; ;; (add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; (load "~/.emacs.d/term.el")

;; Loading my customizations
(load "~/.emacs.d/custom.el")

;; Loading rb init script
(load "~/.emacs.d/rb-init.el")

(load "~/.emacs.d/elixir-init.el")

;; Start the emacs-server
(load "~/.emacs.d/emacs-server.el")

;; JSON MODE
(add-hook 'json-mode-hook
    (lambda ()
      (make-variable-buffer-local 'js-indent-level)
      (setq js-indent-level 2)))
(add-hook 'json-mode 'flymake-json-load)
(add-hook 'json-mode-hook 'paredit-mode)
(add-to-list 'auto-mode-alist '("\\.json" . json-mode))

;; FOR OPTIMIZATION
;; (load "~/.emacs.d/clojure-init.el")
;; (cider-jack-in)

;; Tabbed Browsing Mode
;; tabbar
;; (require 'tabbar)
;; (setq 'tabbar-use-images nil)
;; (setq tabbar-buffer-groups-function
;;       (lambda ()
;;	(list "All")))

;; ;; tabbar _ tabbar-ruler
;; (setq tabbar-ruler-global-tabbar t)
;; (setq tabbar-ruler-global-ruler t)
;; ;;(setq tabbar-ruler-popup-menu t)
;; ;;(setq tabbar-ruler-popup-toolbar t)
;; ;;(setq tabbar-ruler-popup-scrollbar t)

;; ;;(require 'tabbar-ruler)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Configure Emacs Look and Feel Ends here

;; Key Binding C-cl for clearning buffer
(defun erase-buffer-hook ()
  (local-set-key "\C-cl" 'erase-buffer))
(add-hook 'shell-mode-hook 'erase-buffer-hook)

;; No more visible bell ;; black rectangle in the center
(setq visible-bell nil)

;; Enable menu-mar mode
;; (menu-bar-mode 1)

;; Mod line mode
(line-number-mode t)
(column-number-mode t)

(load-theme 'zenburn t)
