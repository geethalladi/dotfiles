;;
;; asciidoc / text mode
;;

(require 'adoc-mode)

(defun self/adoc-mode ()
  "adoc-mode specifications"
  (self/use-variable-width-font)
  (smartparens-mode)
  (flyspell-mode))

(defun self/text-mode ()
  "Text mode customizations"
  ;; using ispell backend for autom completing
  ;; dictionary words
  (self/adoc-mode)
  (setq-local company-backends
              (cons 'company-ispell company-backends))
  (setq-local company-transformers nil))

;; (add-hook 'adoc-mode-hook 'self/adoc-mode)

(add-to-list 'auto-mode-alist '("\\.\\(adoc\\|asciidoc\\|txt\\)$" . self/text-mode))
