;; hard-coding the erlang root dir for now
;; Should be obtaining this from $ERLANG_HOME

;; Setting erlang path variables
(setq erlang-root-dir "/usr/local/Cellar/erlang/23.1.1")
(setq erlang-man-root-dir "/usr/local/Cellar/erlang/23.1.1/lib/erlang/man")
(setq inferior-erlang-machine-options '("-sname" "emacs"))

(setq exec-path
      (cons "/usr/local/Cellar/erlang/23.1.1/bin"
       (cons "/usr/local/Cellar/erlang/23.1.1/lib/erlang/bin" exec-path)))

;; Associating erlang-mode with file extension.
(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))

(setq erlang-emacs-load-path
      "/usr/local/Cellar/erlang/23.1.1/lib/erlang/lib/tools-3.4.1/emacs")

(setq load-path (cons erlang-emacs-load-path load-path))

(require 'smartparens)
(require 'erlang)
(require 'erlang-start)
(require 'erlang-flymake)

(defun self/erlang-mode-hook ()
  "erlang mode customization hook"
  (smartparens-mode 1)
  (yafolding-mode 1))

(add-hook 'erlang-mode-hook 'self/erlang-mode-hook)
(add-hook 'erlang-shell-mode-hook 'smartparens-mode)
