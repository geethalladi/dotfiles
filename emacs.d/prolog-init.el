;; from https://www.metalevel.at/pceprolog/

(setq prolog-system 'swi
      prolog-program-switches '((swi ("-G128M" "-T128M" "-L128M" "-O"))
                                (t nil))
      prolog-electric-if-then-else-flag t)

(defun prolog-insert-comment-block ()
  "Insert a PceEmacs-style comment block like /* - - ... - - */ "
  (interactive)
  (let ((dashes "-"))
    (dotimes (_ 36) (setq dashes (concat "- " dashes)))
    (insert (format "/* %s\n\n%s */" dashes dashes))
    (forward-line -1)
    (indent-for-tab-command)))

;; (global-set-key "\C-cq" 'prolog-insert-comment-block)

;; (global-set-key "\C-cl" (lambda ()
;;                           (interactive)
;;                           (insert ":- use_module(library()).")
;;                           (forward-char -3)))

(add-hook 'prolog-mode-hook
          (lambda ()
            (require 'flymake)
            (make-local-variable 'flymake-allowed-file-name-masks)
            (make-local-variable 'flymake-err-line-patterns)
            (setq flymake-err-line-patterns
                  '(("ERROR: (?\\(.*?\\):\\([0-9]+\\)" 1 2)
                    ("Warning: (\\(.*\\):\\([0-9]+\\)" 1 2)))
            (setq flymake-allowed-file-name-masks
                  '(("\\.pl\\'" flymake-prolog-init)))
            (flymake-mode 1)))

(defun flymake-prolog-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "swipl" (list "-q" "-t" "halt" "-s " local-file))))
