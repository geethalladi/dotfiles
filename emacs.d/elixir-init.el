(require 'alchemist)

(defun custom-erlang-mode-hook ()
  (define-key erlang-mode-map (kbd "M-,") 'alchemist-goto-jump-back))

(add-hook 'erlang-mode-hook 'custom-erlang-mode-hook)

(use-package lsp-mode
  :commands lsp
  :ensure t
  :diminish lsp-mode
  :hook
  (elixir-mode . lsp)
  :init
  (add-to-list 'exec-path "~/installed.d/lsp/elixir"))

(defun self/elixir-mode ()
  "Customizations for elixir mode"
  (message "elixir mode customizations")
  (smartparens-mode 1)
  (yafolding-mode 1)
  (highlight-indentation-mode 1))

(add-hook 'elixir-mode-hook 'self/elixir-mode)
