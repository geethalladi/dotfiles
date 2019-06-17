;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; YAML mode configurations ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'yaml-mode)

;; Required for yaml tree navigation
(require 'hydra)
(require 'indent-tools)

(defun self/yaml-mode-hook ()
  "Customization of yaml mode"
  (highlight-indentation-mode)
  (yafolding-mode)
  (define-key yaml-mode-map (kbd "C-c >") 'indent-tools-hydra/body))

;; (add-hook 'yaml-mode-hook 'highlight-indentation-mode)
;; (add-hook 'yaml-mode-hook 'yafolding-mode)

(add-hook 'yaml-mode-hook 'self/yaml-mode-hook)

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  Markdown mode configurations   ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; markdown-mode binds "Esc-p" which conflicts with helm-projectile-find-file, so
;; unbind it.
(eval-after-load 'markdown-mode
  '(progn
     (define-key markdown-mode-map (kbd "M-p") nil)))
