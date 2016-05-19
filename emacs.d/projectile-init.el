;; Projectile
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'helm)

(helm-projectile-on)
(setq helm-mode-fuzzy-match t)
