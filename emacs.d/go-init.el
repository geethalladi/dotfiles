(add-to-list 'load-path "~/.emacs.d/.cask/26.0/elpa/go-mode-20170726.555/go-mode.el")

(require 'go-mode)
(require 'go-mode-autoloads)
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
