;; default module for collecting personal functions

(defun self/next-meditation-goal (min &optional sec)
  "Given the current time I meditate, find the next goal post"
  (let* ((current (+ (* min 60.0)
                     (if sec sec 0.0)))
         ;; with a 3% improvement
         (new-val (* 1.03 current)))
    ;; "%H:%M:%S" -> Hours required when I go past an hour (I hope I do :)
    (format-time-string "%M:%S" (seconds-to-time new-val) t)))

(defun self/export-to-html-and-open ()
  "Export to html and open in default browser"
  (interactive)
  (browse-url-of-file
   (org-html-export-to-html)))
