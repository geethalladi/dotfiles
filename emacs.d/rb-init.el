;; ;; RUBY

;; ;; COMPANY MODE
;; (global-company-mode t)

;; ;; (require 'grizzl)

(add-to-list 'auto-mode-alist '("\\.rb" . ruby-mode))

(require 'rubocop)
(require 'ruby-tools)
(require 'robe)
(require 'rinari)
(require 'smartparens)
(require 'yafolding)

(require 'bundler)
(require 'rubocop)
(require 'rspec-mode)
(require 'ruby-test-mode)
(require 'ruby-tools)
(require 'rake)
(require 'rvm)

(add-hook 'ruby-mode-hook 'rubocop-mode)
(add-hook 'ruby-mode-hook 'ruby-tools-mode)
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'ruby-mode-hook 'smartparens-mode)
(add-hook 'ruby-mode-hook 'yard-mode)
(add-hook 'ruby-mode-hook 'projectile-mode)
(add-hook 'ruby-mode-hook 'ruby-refactor-mode-launch)
(add-hook 'ruby-mode-hook 'yafolding-mode)
(add-hook 'ruby-mode-hook 'flycheck-mode)

(add-hook 'ruby-mode-hook 'rubocop-mode)
(add-hook 'ruby-mode-hook 'rspec-mode)
(add-hook 'ruby-mode-hook 'ruby-test-mode)

;; (eval-after-load 'rubocop-mode
;;  '(define-key rubocop-mode-map (kdb "s-r" 'rubocop-check-current-file)))

;; (define-key rubocop-mode-map (kbd "s-r") 'rubocop-check-current-file)

(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

;; ;; COMPLETE ANYTHING MODE (COMPANY MODE)
;; (autoload 'company-mode "company" nil t)
;; (add-hook 'robe-mode-hook 'ac-robe-setup)
;; ;; (push 'company-robe company-backends)

;; (push 'company-robe company-backends)
;; (add-hook 'robe-mode-hook 'ac-robe-setup)

;; ; Company mode for inf-ruby
(add-hook 'inf-ruby-mode-hook 'company-mode)
(add-hook 'inf-ruby-mode-hook 'erase-buffer-hook)

;; ;; (add-hook 'enh-ruby-mode-hook 'ruby-electric-mode)
;; ;; (add-hook 'enh-ruby-mode-hook 'auto-complete-mode)

;; Activating RVM
(defadvice inf-ruby-console-auto
    (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

;; Use the rubocop binary in the default gemset
(setq flycheck-ruby-rubocop-executable "~/.rvm/gems/ruby-2.1.10@global/bin/rubocop")

;; ;; (setq enh-ruby-indent-tabs-mode t)

;; ;; (setq-default tab-width 2)
;; ;; (setq enh-ruby-indent-tabs-mode t)
;; ;; (defvaralias 'enh-ruby-indent-level 'tab-width)
;; ;; (defvaralias 'enh-ruby-hanging-indent-level 'tab-width)

(require 'ruby-refactor)

(setenv "PAGER" "less")
(rvm-use-default)

;; (inf-ruby)
;; (robe-start)

;; ;; (eval-after-load 'company
;; ;; '(push 'company-robe company-backends))
