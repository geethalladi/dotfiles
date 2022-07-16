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
(load (expand-file-name "font-init.el" user-emacs-directory))

;; SAVE BACK TO TEMP FOLDER
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
(setq backup-directory-alist '((".*" . (expand-file-name "saves" user-emacs-directory))))

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

;; Start the emacs-server
(load (expand-file-name "emacs-server.el" user-emacs-directory))

(load (expand-file-name "after-init-load.el" user-emacs-directory))
