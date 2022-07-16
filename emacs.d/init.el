;; POST INIT HOOK

(add-hook 'after-init-hook
          (lambda () (load (expand-file-name "after-init.el" user-emacs-directory))))
