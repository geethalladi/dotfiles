(require 'pdf-tools)

;; Install the pdf tools
(use-package pdf-tools
  :config
 ;; initialise
 (pdf-tools-install)
 ;; open pdfs scaled to fit page
 (setq-default pdf-view-display-size 'fit-page)
 ;; automatically annotate highlights
 (setq pdf-annot-activate-created-annotations t)
 ;; use normal isearch
 (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward))

;; pdf-view is literally unusable with linum-mode
;; disable linum mode with pdf-view
(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))
