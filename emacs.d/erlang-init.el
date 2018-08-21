;; hard-coding the erlang root dir for now
;; Should be obtaining this from $ERLANG_HOME

;; Setting erlang path variables
(setq erlang-root-dir "/usr/local/Cellar/erlang/21.0.4")
;; Concatenate with erlang root dir to form the full load path
(setq erlang-emacs-load-path
      (concat (file-name-as-directory erlang-root-dir)
              "lib/erlang/lib/tools-3.0/emacs"))
(setq load-path (cons erlang-emacs-load-path load-path))

(require 'erlang)
(require 'erlang-start)

(require 'smartparens)
(add-hook 'erlang-mode-hook 'smartparens-mode)
(add-hook 'erlang-shell-mode-hook 'smartparens-mode)
