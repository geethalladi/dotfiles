(use-package yaml-mode)
(straight-use-package 'yaml-pro)

(setq treesit-language-source-alist
      '((yaml "https://github.com/ikatyang/tree-sitter-yaml")))
(treesit-install-language-grammar 'yaml)

(defun self/yaml-mode ()
  ;; reference: https://github.com/zkry/yaml-pro

  (yaml-pro-ts-mode 1)
  ;; the original bindings will work as well, these are shorter if you prefer them.
  (keymap-set yaml-pro-ts-mode-map "C-M-n" #'yaml-pro-ts-next-subtree)
  (keymap-set yaml-pro-ts-mode-map "C-M-p" #'yaml-pro-ts-prev-subtree)
  (keymap-set yaml-pro-ts-mode-map "C-M-u" #'yaml-pro-ts-up-level)
  (keymap-set yaml-pro-ts-mode-map "C-M-d" #'yaml-pro-ts-down-level)
  (keymap-set yaml-pro-ts-mode-map "C-M-k" #'yaml-pro-ts-kill-subtree)
  (keymap-set yaml-pro-ts-mode-map "C-M-<backspace>" #'yaml-pro-ts-kill-subtree)
  (keymap-set yaml-pro-ts-mode-map "C-M-a" #'yaml-pro-ts-first-sibling)
  (keymap-set yaml-pro-ts-mode-map "C-M-e" #'yaml-pro-ts-last-sibling)

  (defvar-keymap my/yaml-pro/tree-repeat-map
    :repeat t
    "n" #'yaml-pro-ts-next-subtree
    "p" #'yaml-pro-ts-prev-subtree
    "u" #'yaml-pro-ts-up-level
    "d" #'yaml-pro-ts-down-level
    "m" #'yaml-pro-ts-mark-subtree
    "k" #'yaml-pro-ts-kill-subtree
    "a" #'yaml-pro-ts-first-sibling
    "e" #'yaml-pro-ts-last-sibling
    "SPC" #'my/yaml-pro/set-mark)

  (defun my/yaml-pro/set-mark ()
    (interactive)
    (my/region/set-mark 'my/yaml-pro/set-mark))

  (defun my/region/set-mark (command-name)
    (if (eq last-command command-name)
        (if (region-active-p)
            (progn
              (deactivate-mark)
              (message "Mark deactivated"))
          (activate-mark)
          (message "Mark activated"))
      (set-mark-command nil))))

(add-hook 'yaml-mode-hook 'self/yaml-mode)
