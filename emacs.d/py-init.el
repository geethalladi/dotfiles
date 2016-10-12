;; Python Hook

(add-hook 'python-mode-hook
 (function (lambda ()
             (setq indent-tabs-mode nil
                   python-indent 2
                   tab-width 2))))
(add-hook 'python-mode-hook 'smartparens-mode)
(add-hook 'python-mode-hook 'yafolding-mode)
