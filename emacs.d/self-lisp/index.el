;; default module for collecting personal functions

(defun self/next-meditation-goal (min &optional sec)
  "Given the current time I meditate, find the next goal post"
  (let* ((current (+ (* min 60.0)
                     (if sec sec 0.0)))
         ;; with a 3% improvement
         (new-val (* 1.03 current)))
    ;; "%H:%M:%S" -> Hours required when I go past an hour (I hope I do :)
    (format-time-string "%M:%S" (seconds-to-time new-val) t)))

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
