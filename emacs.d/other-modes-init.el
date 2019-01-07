;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; YAML mode configurations ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'yaml-mode)
(add-hook 'yaml-mode-hook 'highlight-indentation-mode)
(add-hook 'yaml-mode-hook 'yafolding-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; REST Client mode configurations ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'restclient)

(add-to-list 'auto-mode-alist '("\\.\\(rest\\)$" . restclient-mode))
(add-to-list 'auto-mode-alist '("\\.\\(http\\)$" . restclient-mode))

(add-hook 'restclient-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq tab-width 2)))
(add-hook 'restclient-mode-hook 'smartparens-mode)

;; (add-to-list 'company-backends 'company-restclient)
;; (setq tab-always-indent nil)
