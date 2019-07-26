;; No Initial Splash Screen
(setq inhibit-splash-screen t)

;; OPENING IN THE SAME FRAME (NO NEW FRAMES)
(setq ns-pop-up-frames nil)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; PACKAGE ARCHIVE
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
       ("marmalade" . "https://marmalade-repo.org/packages/")
       ("melpa" . "http://melpa.milkbox.net/packages/")))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ;; Org-mode's repository

;; ENABLE CASK

(require 'cask "~/.emacs.d/.cask/26.1/elpa/cask-20180626.1949/cask.el")
(cask-initialize)

;; Setting the location of the cask file
(setq cask-filename "~/.emacs.d/Cask")

;; ENABLE PALLET
(require 'pallet)
(pallet-mode t)

;; SAVE BACK TO TEMP FOLDER
(setq backup-directory-alist '((".*" . "~/.emacs.d/saves")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))

;; Load vendor el files
(add-to-list 'load-path "~/dotfiles/emacs.d/vendor")

(load "~/.emacs.d/after-init-load.el")

(setq mac-shift-modifier 'meta)
(setq ns-function-modifier 'hyper)  ; make Fn key do Hyper

(setq visual-fill-column-width 144)
(global-visual-fill-column-mode 1)

(require 'better-defaults)
;; (require 'ido)
;; (ido-mode 1)
;; (setq ido-everywhere t)
;; (setq ido-enable-flex-matching t)

;; autocompletion in M-x
;; (require 'smex)
;; (global-set-key (kbd "M-x") 'smex)

;; [TODO] Update the exact path of the dictinoary
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/.cask/24.5.1/elpa/auto-complete-20160710.1544/dict")

(global-linum-mode 1)
(setq linum-format "%3d ")

; emacs getting the same path when invoked from GUI
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

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

;; ENABLE PERSISTENT SCRATCH
(persistent-scratch-setup-default)
(persistent-scratch-autosave-mode 1)

;; Never kill scratch buffer
(add-hook 'kill-buffer-query-functions
          (lambda() (not (equal (buffer-name) "*scratch*"))))

;; delete trailing white space
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'whitespace-cleanup)

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

;; magit for GIT
(require 'magit)

(require 'toggle-quotes)
(global-set-key (kbd "C-'") 'toggle-quotes)

;; Disabling menu bar in terminals
(unless (display-graphic-p)
  (message "Disabling menu bar")
  (menu-bar-mode -1))
