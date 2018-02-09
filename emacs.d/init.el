;; NO START SCREEN

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq inhibit-splash-screen t)

;; OPENING IN THE SAME FRAME (NO NEW FRAMES)
(setq ns-pop-up-frames nil)

;; POST INIT HOOK
(add-hook 'after-init-hook (lambda () (load "~/.emacs.d/after-init.el")))

(add-hook 'before-make-frame-hook (lambda () (load "~/.emacs.d/after-init.el")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Automatic Customizations go here ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa"
     "43c1a8090ed19ab3c0b1490ce412f78f157d69a29828aa977dae941b994b4147"
     "82b67c7e21c3b12be7b569af7c84ec0fb2d62105629a173e2479e1053cff94bd"
     "cd560f7570de0dcdcf06953b3f1a25145492a54f100f9c8da3b4091b469f7f02"
     "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" default)))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(org-agenda-files nil)
 '(package-selected-packages (quote (package-build shut-up epl git commander f dash s)))
 '(show-paren-mode t)
 '(tab-width 2)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-function-param ((t (:foreground "Brown"))))
 '(org-done ((t (:foreground "ForestGreen" :weight normal :strike-through t))))
 '(org-headline-done ((((class color) (min-colors 16) (background dark)) (:foreground "LightSalmon" :strike-through t)))))
