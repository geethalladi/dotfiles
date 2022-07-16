;; go-mode-autoloads is no longer needed
;; https://github.com/dominikh/go-mode.el/issues/222
;; (add-to-list 'load-path
;;   (expand-file-name ".cask/26.0/elpa/go-mode-20170726.555/go-mode.el" user-emacs-directory))
;; (require 'go-mode-autoloads)

(require 'go-mode)
(require 'go-autocomplete)

;; uses native auto completion (M-TAB)
;; (depends-on "go-complete")
;; (add-hook 'completion-at-point-functions 'go-complete-at-point)

(defun self/go-mode ()
  "Customizations for go mode"
  (smartparens-global-mode)
  (smartparens-mode)
  (yafolding-mode 1)
  ;; disable company minor mode
  ;; conflicts with auto-complete mode
  (company-mode nil)
  (auto-complete-mode)
  (setq indent-tabs-mode 1)
  (setq tab-width 4))

(add-hook 'go-mode-hook 'self/go-mode)
