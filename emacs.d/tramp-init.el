;; custom configurations for tramp
(require 'tramp)

(setq remote-file-name-inhibit-cache nil)
(setq vc-ignore-dir-regexp
      (format "%s\\|%s"
                    vc-ignore-dir-regexp
                    tramp-file-name-regexp))

(setq tramp-debug-buffer t)
(setq tramp-verbose 1)
(setq tramp-default-method "ssh")

(customize-set-variable 'tramp-use-ssh-controlmaster-options nil)
(customize-set-variable 'tramp-default-method "ssh")

;; The below configuration is not commented to make tramp use the .ssh/config
;; (setq tramp-ssh-controlmaster-options
;;       (concat
;;        "-o ControlPath=~/.ssh/sockets/%%r@%%h-%%p "
;;        "-o ControlMaster=auto -o ControlPersist=yes"))
;; (setq tramp-use-ssh-controlmaster-options t)
;; (customize-set-variable 'tramp-use-ssh-controlmaster-options nil)
