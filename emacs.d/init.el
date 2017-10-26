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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(org-agenda-files (quote ("~/Desktop/plan.org")))
 '(package-selected-packages (quote (package-build shut-up epl git commander f dash s)))
 '(show-paren-mode t)
 '(tab-width 2)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
