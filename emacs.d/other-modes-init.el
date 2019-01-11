;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; YAML mode configurations ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'yaml-mode)
(add-hook 'yaml-mode-hook 'highlight-indentation-mode)
(add-hook 'yaml-mode-hook 'yafolding-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; REST Client mode configurations ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'company)
(require 'restclient)
(require 'company-restclient)

(add-to-list 'auto-mode-alist '("\\.\\(rest\\)$" . restclient-mode))
(add-to-list 'auto-mode-alist '("\\.\\(http\\)$" . restclient-mode))

(defun self/restclient-mode-hook ()
  (add-to-list 'company-backends 'company-restclient)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (smartparens-mode)
  (set (make-local-variable 'company-backends) '(company-restclient))
  (company-mode +1))

(add-hook 'restclient-mode-hook 'self/restclient-mode-hook)

;; (setq tab-always-indent nil)
