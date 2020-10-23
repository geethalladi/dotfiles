;; Install opam
;; Install the following packages
;; $ opam install tuareg merlin ocp-incident

(add-hook 'tuareg-mode 'tuareg-imenu-set-imenu)
(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
    ("\\.topml$" . tuareg-mode))
        auto-mode-alist))
(autoload 'utop-setup-ocaml-buffer "utop" "Top level for OCaml" t)
(autoload 'merlin-mode "merlin" "Merlin mode" t)

;; Add opam emacs directory to the load-path
(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
;; Load merlin-mode
(require 'merlin)

(add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)
(add-hook 'tuareg-mode-hook 'merlin-mode)
(add-hook 'tuareg-mode-hook 'merlin-mode t)
(add-hook 'caml-mode-hook 'merlin-mode t)

(setq merlin-use-auto-complete-mode t)
(setq merlin-error-after-save nil)
;; Enable auto-complete
(setq merlin-use-auto-complete-mode 'easy)
;; Use opam switch to lookup ocamlmerlin binary
(setq merlin-command 'opam)

;; Running UTOP from emacs

;; Setup environment variables using opam
(dolist (var (car (read-from-string (shell-command-to-string "opam config env --sexp"))))
  (setenv (car var) (cadr var)))
;; Update the emacs path
(setq exec-path (append (parse-colon-path (getenv "PATH"))
      (list exec-directory)))
;; Update the emacs load path
(add-to-list 'load-path (expand-file-name "../../share/emacs/site-lisp"
            (getenv "OCAML_TOPLEVEL_PATH")))
;; Automatically load utop.el
(autoload 'utop "utop" "Toplevel for OCaml" t)

;; Adding ocp-indent
(add-to-list 'load-path "~/.opam/default/share/emacs/site-lisp/")
(require 'ocp-indent)
