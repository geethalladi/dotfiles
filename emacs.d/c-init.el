;; initialize the configurations for c major mode
(setq c-default-style
      '((java-mode . "java")
        (c-mode . "linux")
        (other . "gnu")))

(setq-default c-basic-offset 4)

;; (setq c-default-style "linux"
;;       c-basic-offset 4)

(defun self/c-mode ()
  "Customizations for C mode"
  (smartparens-mode)
  (projectile-mode)
  (yafolding-mode)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 4))

(add-hook 'c-mode-hook 'self/c-mode)
