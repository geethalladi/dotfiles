;; Projectile

(require 'projectile)
(require 'helm-projectile)

(define-key projectile-mode-map (kbd "C-x C-p") 'projectile-command-map)
(projectile-mode +1)

(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'helm)

(helm-projectile-on)
(setq helm-mode-fuzzy-match t)

;; line mode for projectile
(setq projectile-mode-line "Project")
