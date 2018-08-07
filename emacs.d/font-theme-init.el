;; THEME INIT

;; default to

;; (load-theme 'zenburn t)

;; (load-theme 'wheatgrass t)
;; (load-theme 'monokai t)
;; (load-theme 'github-modern t)

;; solarized-light theme
;; (add-to-list 'custom-theme-load-path
;;              "~/repo/open-source/emacs-color-theme-solarized")
;; (set-frame-parameter nil 'background-mode 'light)
;; (load-theme 'solarized t)

;; (when (not window-system)
;;  (load-theme 'tango-dark t))

;; (if (window-system)
;;     (load-theme 'leuven t)
;;   (load-theme 'tango-dark t))

(when (window-system)
    (load-theme 'leuven t))

;; FONT INIT

;; Two fonts which look good
;; - Haskling :: 11 :: semi-bold
;; - Consolas :: 12 :: normal

(load "~/.emacs.d/font-ligatures.el")

(set-face-attribute 'default nil :font "Consolas:pixelsize=12:weight=normal")

;; (set-face-attribute 'default nil :font "Monaco-16")
;; (set-face-attribute 'default nil :font "Monaco-13:spacing=110")

;; (set-face-attribute 'default nil :font "Inconsolata-16")
;; (set-face-attribute 'default nil :font "Inconsolata-dz for Powerline:pixelsize=13:spacing=110")

;; (set-face-attribute 'default nil :font "Consolas:pixelsize=16:spacing=110")
;; (set-face-attribute 'default nil :font "Fira Code:pixelsize=15:spacing=110")

;; (set-face-attribute 'default nil :font "Hasklig:pixelsize=13:spacing=110:weight=semi-bold")
;; (set-face-attribute 'default nil :font "Consolas:pixelsize=16:spacing=110:weight=normal")

;; (set-face-attribute 'default nil :font "Hasklig:pixelsize=15:spacing=110:weight=normal")

;; (when (window-system)
;;   (set-face-attribute 'default nil :font "Fira Code:pixelsize=16:spacing=110"))

;; (if (window-system)
;;     (set-face-attribute 'default nil :font "Consolas:pixelsize=16:spacing=110:weight=normal")
;;   (set-face-attribute 'default nil :font "Hasklig:pixelsize=13:spacing=110:weight=medium"))

;; (require 'color-identifiers-mode)
;; (let ((faces '(font-lock-comment-face
;;                font-lock-comment-delimiter-face
;;                font-lock-constant-face
;;                font-lock-type-face
;;                font-lock-function-name-face
;;                font-lock-variable-name-face
;;                font-lock-keyword-face
;;                font-lock-string-face
;;                font-lock-builtin-face
;;                font-lock-preprocessor-face
;;                font-lock-warning-face
;;                font-lock-doc-face)))
;;   (dolist (face faces)
;;     (set-face-attribute face nil :foreground nil :weight 'normal :slant 'normal)))

;; (set-face-attribute 'font-lock-comment-delimiter-face nil :slant 'italic)
;; (set-face-attribute 'font-lock-comment-face nil :slant 'italic)
;; (set-face-attribute 'font-lock-doc-face nil :slant 'italic)
;; (set-face-attribute 'font-lock-keyword-face nil :weight 'bold)
;; (set-face-attribute 'font-lock-builtin-face nil :weight 'bold)
;; (set-face-attribute 'font-lock-preprocessor-face nil :weight 'bold)
