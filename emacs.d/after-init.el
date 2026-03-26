;; No Initial Splash Screen
(setq inhibit-splash-screen t)

(defun self/no-menu-bar-in-terminal ()
  "No menu bar when running in the terminal"
  (unless (display-graphic-p)
    (menu-bar-mode -1)))

;; in standalone (terminal) emacs
(self/no-menu-bar-in-terminal)

;; in emacsclient
(add-to-list 'after-make-frame-functions
             (lambda (frame) (self/no-menu-bar-in-terminal)))

;; show only emergency warnings
(setq warning-minimum-level :emergency)

;; for faster cursor movements
;; https://github.com/doomemacs/doomemacs/issues/2217
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(setq display-line-numbers-type nil)

;; https://emacs.stackexchange.com/questions/28736/emacs-pointcursor-movement-lag/28746
(setq auto-window-vscroll nil)

;; setting GC threshold
(setq gc-cons-threshold
      (if (display-graphic-p)
          ;; 200 MB with cocoa emacs
          (* 200 (expt 10 6))
        ;; 10 MB for terminal
        (* 10 (expt 10 6))))

;; OPENING IN THE SAME FRAME (NO NEW FRAMES)
(setq ns-pop-up-frames nil)

;; no toolbar
(tool-bar-mode -1)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; eager loading font customizations
(load (expand-file-name "font-init.el" user-emacs-directory))

;; SAVE BACK TO TEMP FOLDER
(setq auto-save-file-name-transforms `((".*"
                                        ,(expand-file-name "autosaves/\\1" user-emacs-directory)
                                        t)))
(setq backup-directory-alist `((".*" .
                                ,(expand-file-name "saves" user-emacs-directory))))

;; save configurations to this file - (but don't load themm :)
(setq custom-file (expand-file-name "emacs-custom.el" user-emacs-directory))

;; Never kill scratch buffer
(add-hook 'kill-buffer-query-functions
          (lambda () (not (equal (buffer-name) "*scratch*"))))

;; delete trailing white space
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'whitespace-cleanup)

;; TODO: make this conditional
(defun -mac-set-options-command-key ()
  "Use Options as Meta Key"
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'super))

(-mac-set-options-command-key)

(defun self/init-packages ()
  "Initialise all the dependent packages"
  (message "Init packages")
  (require 'package)
  ;; (add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  ;; Removing the org package archive
  ;; (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  (package-initialize)

  (add-to-list 'load-path
               (expand-file-name "use-package" user-emacs-directory))
  (eval-when-compile
    ;; Following line is not needed if use-package.el is in ~/.emacs.d
    (require 'use-package)
    (require 'use-package-ensure)
    (setq use-package-always-ensure t
          use-package-expand-minimally t)))

(defun self/install-packages-with-straight ()
  "Install elisp packages using straight.el"
  (straight-use-package 'f)
  (straight-use-package 'git)
  (straight-use-package 'flymake-go)
  (straight-use-package 'rg)
  (straight-use-package 'ebuku)
  (straight-use-package 'helm-ag)
  (straight-use-package 'github-modern-theme)
  (straight-use-package 'projectile)
  (straight-use-package 'helm-projectile)
  (straight-use-package 'projectile-rails)
  (straight-use-package 'mocha)
  (straight-use-package 'commander)
  (straight-use-package 'anaconda-mode)
  (straight-use-package 'pocket-reader)
  (straight-use-package 'hasklig-mode)
  (straight-use-package 'persistent-scratch)
  (straight-use-package 'dash-functional)
  (straight-use-package 'docker-tramp)
  (straight-use-package 'rubocop)
  (straight-use-package 'rspec-mode)
  (straight-use-package 'org-roam)
  (straight-use-package 'espresso-theme))

(self/init-packages)

(self/install-packages-with-straight)

;; Start the emacs-server
(load (expand-file-name "emacs-server.el" user-emacs-directory))
(load (expand-file-name "after-init-load.el" user-emacs-directory))
