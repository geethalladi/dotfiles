;; Emacs font customizations
;; Moving this into its own module

(set-face-attribute 'default nil
                    :family "JetBrains Mono"
                    :height 150
                    :weight 'normal
                    :width 'expanded
                    :slant 'normal)

(defun self/use-variable-width-font ()
  "Use variable width font in current buffer"
  (message "Using Variable width font")
  (interactive)
  ;; (load-theme 'poet t)
  (variable-pitch-mode)
  (setq buffer-face-mode-face
        '(:family "PT Sans"
          :height 180
          :width expanded
          :weight normal
          :slant normal))
  (buffer-face-mode t)
  (visual-line-mode t))

(defun self/use-terminal-font ()
  "set terminal style font"
   (interactive)
   (setq buffer-face-mode-face '(:family "Consolas for Powerline" :height 140 :weight bold))
   (setq visual-fill-column-width 240)
   (buffer-face-mode))

;; (set-face-attribute 'default nil
;;                     :family "PT Mono"
;;                     :height 160
;;                     :weight 'normal
;;                     :width 'expanded
;;                     :slant 'normal)

;; fonts I liked
;; - JetBrains Mono               :: 15 :: normal
;; - JetBrainsMono Nerd Font Mono :: 15 :: normal
;; - Consolas                     :: 14 :: normal
;; - PT Mono                      :: 16 :: normal
;; - Haskling                     :: 11 :: semi-bold
;; - Fira Code                    :: 15 :: normal

;; (set-face-attribute 'default nil :font "Fira Code:pixelsize=15:spacing=110:weight=normal")
;; (load "~/.emacs.d/vendor/fira-code.el")

;; (set-face-attribute 'default nil :font "Consolas:pixelsize=14:weight=normal")
;; (set-face-attribute 'default nil :font "Hasklig:pixelsize=13:spacing=110:weight=normal")

;; (set-face-attribute 'default nil :font "Monaco-16")
;; (set-face-attribute 'default nil :font "Monaco-13:spacing=110")

;; (set-face-attribute 'default nil :font "Inconsolata-16")
;; (set-face-attribute 'default nil :font "Inconsolata-dz for Powerline:pixelsize=13:spacing=110")

;; (set-face-attribute 'default nil :font "Consolas:pixelsize=16:spacing=110")
;; (set-face-attribute 'default nil :font "Fira Code:pixelsize=15:spacing=110")

;; (set-face-attribute 'default nil :font "Hasklig:pixelsize=13:spacing=110:weight=semi-bold")
;; (set-face-attribute 'default nil :font "Consolas:pixelsize=16:spacing=110:weight=normal")

;; (set-face-attribute 'default nil :font "Hasklig:pixelsize=15:spacing=110:weight=normal")

;; (set-face-attribute 'default nil :font "Consolas:pixelsize=14:spacing=110:weight=normal")
