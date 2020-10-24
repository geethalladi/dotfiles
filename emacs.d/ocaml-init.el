;; Install opam
;; Install the following packages
;; $ opam install tuareg merlin ocp-incident utop

(defun self/remove-conflicting-keybindings (mode binding)
  "remove conflicting keybindings"
  (let ((oldmap (cdr (assoc mode minor-mode-map-alist)))
        (newmap (make-sparse-keymap)))
    (set-keymap-parent newmap oldmap)
    (define-key newmap binding nil)
    (make-local-variable 'minor-mode-overriding-map-alist)
    (push `(,mode . ,newmap) minor-mode-overriding-map-alist)))

;; Add opam emacs directory to the load-path
(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))


;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;; (require 'opam-user-setup "~/.emacs.d/vendor/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line

;; Use opam switch to lookup ocamlmerlin binary
(setq merlin-command 'opam)
(setq merlin-use-auto-complete-mode nil)

(autoload 'merlin-mode "merlin" "Merlin mode" t)
(autoload 'utop "utop" "Toplevel for OCaml" t)

(require 'merlin)
(require 'utop)
(require 'ocp-indent)

;; Setup environment variables using opam
(dolist (var (car (read-from-string (shell-command-to-string "opam config env --sexp"))))
  (setenv (car var) (cadr var)))

;; Update the emacs path
(setq exec-path (append (parse-colon-path (getenv "PATH"))
                        (list exec-directory)))

(defun self/-ocaml-mode ()
  "Customizations for OCaml mode"
  (merlin-mode)
  (smartparens-mode)
  (utop-minor-mode)
  (setq merlin-error-after-save nil)
  (self/remove-conflicting-keybindings 'merlin-mode (kbd "C-c C-p"))
  ;; disable autocomplete mode
  (auto-complete-mode -1))

(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist))

(add-hook 'tuareg-mode-hook 'self/-ocaml-mode)

;; (tuareg-imenu-set-imenu)

;; Enable auto-complete
;; (setq merlin-use-auto-complete-mode 'easy)

;; ;; Update the emacs load path
;; (add-to-list 'load-path (expand-file-name "../../share/emacs/site-lisp"
;;                                           (getenv "OCAML_TOPLEVEL_PATH")))
