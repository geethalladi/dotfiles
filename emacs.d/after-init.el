;; No Initial Splash Screen
(setq inhibit-splash-screen t)

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

;; (add-to-list 'default-frame-alist '(fullscreen . maximized))

;; eager loading font customizations
(load "~/.emacs.d/font-init.el")

;; SAVE BACK TO TEMP FOLDER
(setq backup-directory-alist '((".*" . "~/.emacs.d/saves")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))

;; save configurations to this file - (but don't load themm :)
(setq custom-file "~/.emacs.d/emacs-custom.el")

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

;; Start the emacs-server
(load "~/.emacs.d/emacs-server.el")

(load "~/.emacs.d/after-init-load.el")
