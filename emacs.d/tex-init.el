(require 'tex-mode)

;; taken from stackoverflow and made minor changes
(defun self/render-pdf ()
  "Render pdf from a tex file"
  (interactive
   (let* ((name buffer-file-name)
          (basename (substring name 0 -4))
          (pdf-file (concat basename ".pdf"))
          (cmd (format "pdflatex %s" name)))
    (delete-other-windows)
    (split-window-horizontally)
    (split-window-vertically)
    (shell-command cmd)
    (other-window 2)
    (find-file pdf-file)
    (balance-windows))))

(use-package tex-mode
  :ensure t
  :bind (:map latex-mode-map
              (("C-x v" . self/render-pdf))))
