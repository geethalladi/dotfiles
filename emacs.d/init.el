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

;; (add-hook 'before-make-frame-hook (lambda () (load "~/.emacs.d/after-init.el")))
