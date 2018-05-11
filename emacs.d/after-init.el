;; PACKAGE ARCHIVE
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
       ("marmalade" . "https://marmalade-repo.org/packages/")
       ("melpa" . "http://melpa.milkbox.net/packages/")))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ;; Org-mode's repository

;; ENABLE CASK


(require 'cask "~/.emacs.d/.cask/26.0/elpa/cask-20161024.1205/cask.el")
(cask-initialize)

;; ENABLE PALLET
(require 'pallet)
(pallet-mode t)

;; SAVE BACK TO TEMP FOLDER
(setq backup-directory-alist '((".*" . "~/.emacs.d/saves")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))

(setq mac-shift-modifier 'meta)

(setq visual-fill-column-width 144)
(global-visual-fill-column-mode 1)

;; (require 'ido)
;; (ido-mode 1)
;; (setq ido-everywhere t)
;; (setq ido-enable-flex-matching t)

;; etags table
;; (require 'etags-table)
;; (require 'etags-select)

;; autocompletion in M-x
;; (require 'smex)
;; (global-set-key (kbd "M-x") 'smex)

;;;; ENABLING THE MOST USED MODES BY DEFAULT

;; AUTO COMPLETE
(require 'auto-complete-config)
(ac-config-default)

;; [TODO] Update the exact path of the dictinoary
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/.cask/24.5.1/elpa/auto-complete-20160710.1544/dict")

(global-linum-mode 1)
(setq linum-format "%3d ")

; emacs getting the same path when invoked from GUI
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Use coreutils ls for dired program
;; (setq insert-directory-program (executable-find "gls"))

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

;; Dash at point for emacs
(require 'dash-at-point)
(autoload 'dash-at-point "dash-at-point"
    "Search the word at point with Dash." t nil)
(global-set-key "\C-cd" 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)

;; ENABLE PERSISTENT SCRATCH
(persistent-scratch-setup-default)
(persistent-scratch-autosave-mode 1)

;; delete trailing white space
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Tabbed Browsing Mode
;; tabbar
;; (require 'tabbar)
;; (setq 'tabbar-use-images nil)
;; (setq tabbar-buffer-groups-function
;;       (lambda ()
;;	(list "All")))

;; tabbar _ tabbar-ruler
;; (setq tabbar-ruler-global-tabbar t)
;; (setq tabbar-ruler-global-ruler t)
;; (setq tabbar-ruler-popup-menu t)
;; (setq tabbar-ruler-popup-toolbar t)
;; (setq tabbar-ruler-popup-scrollbar t)

;; (require 'tabbar-ruler)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Configure Emacs Look and Feel Ends here

;; Key Binding C-cl for clearning buffer
(defun erase-buffer-hook ()
  (local-set-key "\C-cl" 'erase-buffer))
(add-hook 'shell-mode-hook 'erase-buffer-hook)

;; Found a way to overwrite the selected text and replace it with
;; the yanked content
;; (delete-selection-mode 1)

;; No more visible bell ;; black rectangle in the center
(setq visible-bell nil)

;; Enable menu-mar mode
(menu-bar-mode 1)

;; Mod line mode
(line-number-mode t)
(visual-line-mode 1)
(column-number-mode t)

;; default to
;; (load-theme 'zenburn t)
;; (load-theme 'wheatgrass t)
;; (load-theme 'monokai t)
;; (load-theme 'github-modern t)

;; solarized-light theme
;; (add-to-list 'custom-theme-load-path
;;              "~/repo/open-source/emacs-color-theme-solarized")
;; (set-frame-parameter nil 'background-mode 'light)
;; (load-theme 'solarized t)

;; (when (not window-system)
;;  (load-theme 'tango-dark t))

;; (if (window-system)
;;     (load-theme 'leuven t)
;;   (load-theme 'monokai t))

;; (load-theme 'zenburn t)

(load-theme 'leuven t)

;; Smartparens mode
(require 'smartparens)
(show-paren-mode t)
(show-smartparens-global-mode t)
;; magit for GIT
(require 'magit)

;; DIRTREE MODE
;; (require 'dirtree) ;; FOR OPTIMIZATION
(require 'all-the-icons)
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-smart-open t) ;; Flag to open neotree for the current dir

;; FOR OPTIMIZATION
;; (setenv "TMPDIR" "/var/tmp") ;; TMPDIR to be used by tramp-mode
;; (eval-after-load 'tramp
;;   '(vagrant-tramp-enable))
;; (require 'tramp)

;; ;; SASS
;; ;; (add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; Powerline configuration for emacs
(add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
 (require 'powerline)
 ;; (custom-set-faces
 ;;  '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 ;;  '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))
(setq powerline-arrow-shape 'curve)

(require 'yasnippet)
(yas-global-mode 1)

(require 'toggle-quotes)
(global-set-key (kbd "C-'") 'toggle-quotes)

(load "~/.emacs.d/after-init-load.el")

(setq ns-pop-up-frames nil)
