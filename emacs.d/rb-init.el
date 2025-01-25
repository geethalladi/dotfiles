;; ;; RUBY

;; ;; COMPANY MODE
;; (global-company-mode t)

;; ;; (require 'grizzl)

;; (use-package rhtml-mode)
;; (use-package rinari)
(use-package robe
  :bind
  ("C-c j" . robe-jump))

;; (use-package rubocop)
;; (use-package ruby-compilation)
;; (use-package ruby-electric)
;; (use-package ruby-refactor)
;; (use-package ruby-tools)
;; (use-package rake)
;; (use-package ruby-test-mode)
(use-package rvm)
(use-package inf-ruby)
;; (use-package enh-ruby-mode)
;; (use-package bundler)

(add-to-list 'auto-mode-alist '("\\.rb" . ruby-mode))

(require 'rubocop)
;; (require 'ruby-tools)
(require 'robe)
;; (require 'rinari)
(require 'smartparens)
(require 'yafolding)
(require 'yard-mode)

;; (require 'bundler)
;; (require 'rubocop)
;; (require 'rspec-mode)
;; (require 'ruby-test-mode)
;; (require 'ruby-tools)
;; (require 'rake)
(require 'rvm)

;; (add-hook 'ruby-mode-hook 'rubocop-mode)
;; (add-hook 'ruby-mode-hook 'ruby-tools-mode)
;; (add-hook 'ruby-mode-hook 'yard-mode)
;; (add-hook 'ruby-mode-hook 'ruby-refactor-mode-launch)
;; (add-hook 'ruby-mode-hook 'flycheck-mode)

(add-hook 'ruby-mode-hook
          (lambda ()
            (rvm-activate-corresponding-ruby)
            (smartparens-mode)
            (yafolding-mode)
            (robe-mode)
            (projectile-mode)
            (rspec-mode)
            ;; (ruby-test-mode)
            (company-mode)))

;; (add-hook 'ruby-mode-hook 'rubocop-mode)
;; (add-hook 'ruby-mode-hook 'ruby-test-mode)

;; (eval-after-load 'rubocop-mode
;;  '(define-key rubocop-mode-map (kdb "s-r" 'rubocop-check-current-file)))

;; (define-key rubocop-mode-map (kbd "s-r") 'rubocop-check-current-file)

;; (add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

;; ;; COMPLETE ANYTHING MODE (COMPANY MODE)
;; (autoload 'company-mode "company" nil t)
;; (add-hook 'robe-mode-hook 'ac-robe-setup)
;; ;; (push 'company-robe company-backends)

;; (push 'company-robe company-backends)
;; (add-hook 'robe-mode-hook 'ac-robe-setup)

;; ; Company mode for inf-ruby
;; (add-hook 'inf-ruby-mode-hook 'company-mode)
(add-hook 'inf-ruby-mode-hook 'erase-buffer-hook)

;; ;; (add-hook 'enh-ruby-mode-hook 'ruby-electric-mode)
;; ;; (add-hook 'enh-ruby-mode-hook 'auto-complete-mode)

;; Activating RVM
(defadvice inf-ruby-console-auto
    (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

;; switch to inf-ruby from rspec-compilation mode
;; on C-x C-q
(inf-ruby-switch-setup)

;; Use the rubocop binary in the default gemset
;; (setq flycheck-ruby-rubocop-executable "~/.rvm/gems/ruby-2.1.10@global/bin/rubocop")

;; ;; (setq enh-ruby-indent-tabs-mode t)

;; ;; (setq-default tab-width 2)
;; ;; (setq enh-ruby-indent-tabs-mode t)
;; ;; (defvaralias 'enh-ruby-indent-level 'tab-width)
;; ;; (defvaralias 'enh-ruby-hanging-indent-level 'tab-width)

;; (require 'ruby-refactor)

(setenv "PAGER" "less")
;; (setq rspec-use-rvm t)
;; (rvm-use-default)

(require 'projectile-rails)
(projectile-rails-global-mode)
;; (define-key projectile-rails-mode-map (kbd "s-r") 'hydra-projectile-rails/body)

;; TODO: fix the keymap priority
(defun self/-rails-mode-keybindings (map)
  "Customizing rails mode keybindings"

  ;; invert find and find-current
  (define-key map (kbd "M") 'projectile-rails-find-model)
  (define-key map (kbd "m") 'projectile-rails-find-current-model)

  (define-key map (kbd "C") 'projectile-rails-find-controller)
  (define-key map (kbd "c") 'projectile-rails-find-current-controller)

  (define-key map (kbd "V") 'projectile-rails-find-view)
  (define-key map (kbd "v") 'projectile-rails-find-current-view)

  (define-key map (kbd "J") 'projectile-rails-find-javascript)
  (define-key map (kbd "j") 'projectile-rails-find-current-javascript)

  (define-key map (kbd "S") 'projectile-rails-find-stylesheet)
  (define-key map (kbd "s") 'projectile-rails-find-current-stylesheet)

  (define-key map (kbd "H") 'projectile-rails-find-helper)
  (define-key map (kbd "h") 'projectile-rails-find-current-helper)

  (define-key map (kbd "P") 'projectile-rails-find-spec)
  (define-key map (kbd "p") 'projectile-rails-find-current-spec)

  (define-key map (kbd "T") 'projectile-rails-find-test)
  (define-key map (kbd "t") 'projectile-rails-find-current-test)

  (define-key map (kbd "N") 'projectile-rails-find-migration)
  (define-key map (kbd "n") 'projectile-rails-find-current-migration)

  (define-key map (kbd "R") 'projectile-rails-console)
  (define-key map (kbd "r") 'projectile-rails-server)

  (define-key map (kbd "U") 'projectile-rails-find-fixture)
  (define-key map (kbd "u") 'projectile-rails-find-current-fixture)

  (define-key map (kbd "Z") 'projectile-rails-find-serializer)
  (define-key map (kbd "z") 'projectile-rails-find-current-serializer))

;; rails mode map prefix
(define-key projectile-rails-mode-map (kbd "C-c l") 'projectile-rails-command-map)

;; (self/-rails-mode-keybindings 'projectile-rails-mode-map)

;; (inf-ruby)
;; (robe-start)

;; ;; (eval-after-load 'company
;; ;; '(push 'company-robe company-backends))
