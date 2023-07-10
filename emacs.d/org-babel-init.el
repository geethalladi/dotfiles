;; added from http://doc.norang.ca/org-mode.html#PlantUML

;;
;;  Plantuml Configuration
;;

(defun self/plantuml-mode ()
  "Plantuml mode customization"
  (smartparens-mode 1))
(add-hook 'plantuml-mode-hook 'self/plantuml-mode)

(setq org-ditaa-jar-path
      (expand-file-name "vendor/org-mode/contrib/scripts/ditaa.jar" user-emacs-directory))

(setq plantuml-jar-path
      (expand-file-name "vendor/org-mode/contrib/scripts/plantuml.jar" user-emacs-directory))

(setq org-plantuml-jar-path
      (expand-file-name "vendor/org-mode/contrib/scripts/plantuml.jar" user-emacs-directory))

(setq plantuml-default-exec-mode 'jar)

(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)

; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")

(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))

(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote ((emacs-lisp . t)
         (dot . t)
         (ditaa . t)
         (R . t)
         (python . t)
         (ruby . t)
         (gnuplot . t)
         (clojure . t)
         (shell . t)
         (ledger . t)
         (org . t)
         (plantuml . t)
         (latex . t))))

; Do not prompt to confirm evaluation
; This may be dangerous - make sure you understand the consequences
; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)

;; image width in org mode
(setq org-image-actual-width 900)

; Use fundamental mode when editing plantuml blocks with C-c '
(add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))
