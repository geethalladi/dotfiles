;; Install opam
;; Install the following packages
;; $ opam install tuareg merlin ocp-incident utop

;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "opam-user-setup.el")

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

;; Update the emacs path
(setq exec-path (append (parse-colon-path (getenv "PATH"))
                        (list exec-directory)))

;; Setup environment variables using opam
(dolist (var (car (read-from-string (shell-command-to-string "opam config env --sexp"))))
  (setenv (car var) (cadr var)))

;; Use opam switch to lookup ocamlmerlin binary
(setq merlin-command 'opam)
(setq merlin-use-auto-complete-mode nil)
(setq merlin-error-after-save nil)

;; (autoload 'merlin-mode "merlin" "Merlin mode" t)
;; (autoload 'utop "utop" "Toplevel for OCaml" t)

(require 'merlin)
(require 'utop)
(require 'ocp-indent)
(require 'ocamlformat)

;; TODO: Introduces auto-complete mode magically; Need to analyse later
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;; (require 'opam-user-setup (expand-file-name "vendor/opam-user-setup.el" user-emacs-directory))
;; ## end of OPAM user-setup addition for emacs / base ## keep this line

(defun self/-ocaml-mode ()
  "Customizations for OCaml mode"
  (merlin-mode)
  (utop-minor-mode)
  (ocp-setup-indent)
  (smartparens-mode)
  ;; disable autocomplete mode
  (auto-complete-mode -1)
  (self/remove-conflicting-keybindings 'merlin-mode (kbd "C-c C-p")))

(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist))

(add-hook 'tuareg-mode-hook 'self/-ocaml-mode)

;; ## end of OPAM user-setup addition for emacs / base ## keep this line
;; (tuareg-imenu-set-imenu)

;; Enable auto-complete
;; (setq merlin-use-auto-complete-mode 'easy)

;; ;; Update the emacs load path
;; (add-to-list 'load-path (expand-file-name "../../share/emacs/site-lisp"
;;                                           (getenv "OCAML_TOPLEVEL_PATH")))
