;; NO START SCREEN
(setq inhibit-splash-screen t)

;; OPENING IN THE SAME FRAME (NO NEW FRAMES)
(setq ns-pop-up-frames nil)

;; POST INIT HOOK
(add-hook 'after-init-hook (lambda () (load "~/.emacs.d/after-init.el")))
