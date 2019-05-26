;; hard-coding the erlang root dir for now
;; Should be obtaining this from $ERLANG_HOME

;; Setting erlang path variables
(setq erlang-root-dir "/usr/local/Cellar/erlang/21.0.6")
(setq erlang-man-root-dir "/usr/local/Cellar/erlang/21.0.6/lib/erlang/man")
(setq inferior-erlang-machine-options '("-sname" "emacs"))

;; Associating erlang-mode with file extension.
(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))

;; Concatenate with erlang root dir to form the full load path
(setq erlang-emacs-load-path
      (concat (file-name-as-directory erlang-root-dir)
              "lib/erlang/lib/tools-3.0/emacs"))
(setq load-path (cons erlang-emacs-load-path load-path))

(require 'smartparens)
(require 'erlang)
(require 'erlang-start)

;; (require 'edts)
;; (require 'edts-start)

(defun self/erlang-mode-hook ()
  "erlang mode customization hook"
  (smartparens-mode 1))

(add-hook 'erlang-mode-hook 'self/erlang-mode-hook)
(add-hook 'erlang-shell-mode-hook 'smartparens-mode)
