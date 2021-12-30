(require 'clojure-mode)
(require 'cider)

(defun self/-clojure-mode ()
  "Clojure mode customization"
  (show-paren-mode 1)
  (smartparens-mode)
  (yafolding-mode)
  (paxedit-mode)
  (subword-mode)
  (turn-on-eldoc-mode)
  (rainbow-delimiters-mode)
  (rainbow-identifiers-mode)
  ;; (inf-clojure-minor-mode)

  ;; using function style indent for match / matche
  ;; '1' means the body comes after the first argument
  ;; https://github.com/clojure-emacs/clojure-mode/tree/5.3.0#indentation-of-macro-forms
  (define-clojure-indent
    (-> 1)
    (--> 1)
    (match 1)
    (matche 1))

  ;; Skip adding cider mode for now
  (self/-add-cider-mode)
  (hungry-delete-mode))

(add-hook 'clojure-mode-hook 'self/-clojure-mode)

(defun self/-add-cider-mode ()
  "Adding cider minor mode for clojure editing"

  ;; (add-to-list 'same-window-buffer-names "<em>nrepl</em>")

  (setq nrepl-log-messages t)
  (setq nrepl-buffer-name-separator "-")
  (setq nrepl-popup-stacktraces nil)

  ;; no longer prompt while asking for doc-at-point
  (setq cider-prompt-for-symbol nil)

  (add-hook 'cider-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'cider-mode-hook 'smartparens-mode)
  (add-hook 'cider-mode-hook #'company-mode)

  (add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'cider-repl-mode-hook 'smartparens-mode)
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-repl-mode-hook '(lambda () (linum-mode 0)))

  (define-key cider-mode-map (kbd "C-c C-d z") 'zeal-at-point)

  (define-key cider-mode-map (kbd "C-c C-n") 'self/cider-pprint-last-sexp)

  (add-hook 'clojure-mode-hook #'cider-mode))

;; extension to cider
;; print the output to popup buffer (for API response)
;; reference: https://github.com/clojure-emacs/cider/commit/34783f5551c656667c20217171179769a3bc6bc8

(defun self/cider-pprint-last-sexp (&optional _buffer)
  "Evaluate the sexp preceding point and pprint its value.
   display in a popup buffer."
  (interactive "P")
  (let* ((buffer (current-buffer))
         (result-buffer (cider-popup-buffer cider-result-buffer nil 'clojure-mode 'ancillary))
         (handler (self/-cider-popup-eval-out-handler result-buffer))
         (form (cider-last-sexp 'bounds)))
    (with-current-buffer buffer
      (cider-interactive-eval (when (stringp form) form)
                              handler
                              (when (consp form) form)
                              (cider--nrepl-print-request-map fill-column)))))

(defun self/-cider-popup-eval-out-handler (&optional buffer)
  "Make a handler for evaluating and printing stdout/stderr in popup BUFFER"
  (cl-flet ((popup-output-handler (buffer str)
                                  (cider-emit-into-popup-buffer buffer
                                                                (ansi-color-apply str)
                                                                nil
                                                                t)))
    (nrepl-make-response-handler (or buffer (current-buffer))
                                 '()
                                 ;; stdout handler
                                 #'popup-output-handler
                                 ;; stderr handler
                                 #'popup-output-handler
                                 '())))

;; TODO:
;; unbind C-c C-p p
;; C-x C-p to cider-pprint
