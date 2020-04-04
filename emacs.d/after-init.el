;; No Initial Splash Screen
(setq inhibit-splash-screen t)

;; OPENING IN THE SAME FRAME (NO NEW FRAMES)
(setq ns-pop-up-frames nil)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(set-face-attribute 'default nil
                    :family "Consolas"
                    :height 160
                    :weight 'normal
                    :width 'expanded
                    :slant 'normal)

;; SAVE BACK TO TEMP FOLDER
(setq backup-directory-alist '((".*" . "~/.emacs.d/saves")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))

;; Start the emacs-server
(load "~/.emacs.d/emacs-server.el")

(load "~/.emacs.d/after-init-load.el")

;; Never kill scratch buffer
(add-hook 'kill-buffer-query-functions
          (lambda () (not (equal (buffer-name) "*scratch*"))))

;; delete trailing white space
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'whitespace-cleanup)
