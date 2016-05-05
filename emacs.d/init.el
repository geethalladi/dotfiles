;; OPENING IN THE SAME FRAME (NO NEW FRAMES)
(setq ns-pop-up-frames nil)

;; FONT INIT
;; (set-face-attribute 'default nil :font "Monaco-16")
(set-face-attribute 'default nil :font "Inconsolata-dz for Powerline:pixelsize=15:spacing=110")
;;                    "Inconsolata-dz-15")

;; (set-face-attribute 'default nil :font "Monaco-14:spacing=110")

;; NO START SCREEN
(setq inhibit-splash-screen t)

;; POP UP SCREEN DISABLED
(setq ns-pop-up-frames nil)

;; SAVE BACK TO TEMP FOLDER
(setq backup-directory-alist '((".*" . "~/.emacs.d/saves")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))

;; FIX THE PATH VARIABLE
;; (defun set-exec-path-from-shell-PATH ()
;;   (let ((path-from-shell (shell-command-to-string "TERM=vt100 $SHELL -i -c 'echo $PATH'")))
;;     (setenv "PATH" path-from-shell)
;;     (setq exec-path (split-string path-from-shell path-separator))))
;; (when window-system (set-exec-path-from-shell-PATH))

;; PACKAGE ARCHIVE
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
       ("marmalade" . "https://marmalade-repo.org/packages/")
       ("melpa" . "http://melpa.milkbox.net/packages/")))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ;; Org-mode's repository

;; POST INIT HOOK
(add-hook 'after-init-hook (lambda () (load "~/.emacs.d/after-init.el")))

;; EMACS MAXIMIZED
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("e14f8791b180b69f95550ae9fb6b3fa2321115197908f0a8a2cd924bd5acc86f" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "19352d62ea0395879be564fc36bc0b4780d9768a964d26dfae8aad218062858d" default)))
 '(ecb-layout-window-sizes
   (quote
    (("left8"
      (ecb-directories-buffer-name 0.27722772277227725 . 0.2962962962962963)
      (ecb-sources-buffer-name 0.27722772277227725 . 0.24074074074074073)
      (ecb-methods-buffer-name 0.27722772277227725 . 0.25925925925925924)
      (ecb-history-buffer-name 0.27722772277227725 . 0.18518518518518517)))))
 '(ecb-options-version "2.40")
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(show-paren-mode t)
 '(tab-width 2)
 '(tool-bar-mode nil))

(setq mac-shift-modifier 'meta)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
