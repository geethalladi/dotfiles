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

(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
;; (require 'cask "~/.emacs.d/.cask/26.1/elpa/cask-20180626.1949/cask.el")
(cask-initialize)

;; Setting the location of the cask file
(setq cask-filename "~/.emacs.d/Cask")

;; ENABLE PALLET
(require 'pallet)
(pallet-mode t)
(set-face-attribute 'default nil
                    :family "Consolas"
                    :height 160
                    :weight 'normal
                    :width 'expanded
                    :slant 'normal)

;; SAVE BACK TO TEMP FOLDER
(setq backup-directory-alist '((".*" . "~/.emacs.d/saves")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))

;; Load vendor el files
(add-to-list 'load-path "~/dotfiles/emacs.d/vendor")

(load "~/.emacs.d/after-init-load.el")

; emacs getting the same path when invoked from GUI
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; ENABLE PERSISTENT SCRATCH
(persistent-scratch-setup-default)
(persistent-scratch-autosave-mode 1)

;; Never kill scratch buffer
(add-hook 'kill-buffer-query-functions
          (lambda() (not (equal (buffer-name) "*scratch*"))))

;; delete trailing white space
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'whitespace-cleanup)

