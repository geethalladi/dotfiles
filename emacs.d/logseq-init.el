(defun self/org-tags-to-logseq-string (line)
  "Convert org-mode :tag1:tag2: in a single LINE string to Logseq #tag1 #tag2."
  (if (string-match "\\s-+\\(:[a-zA-Z0-9_@#%:]+:\\)\\s-*$" line)
      (let* ((tag-block (match-string 1 line))
             (tags (split-string (string-trim tag-block ":") ":" t))
             (logseq-tags (mapconcat (lambda (tag) (concat "#" tag)) tags " ")))
        (replace-regexp-in-string
         "\\s-+:[a-zA-Z0-9_@#%:]+:\\s-*$"
         (concat " " logseq-tags)
         line))
    line))


(defun self/org-region-to-logseq-string (start end)
  "Get selected region from START to END and convert each line to Logseq format."
  (let* ((text (buffer-substring-no-properties start end))
         (lines (split-string text "\n" t)))
    (mapconcat #'self/org-tags-to-logseq-string lines "\n")))


(defun self/org-to-logseq (start end)
  "Convert selected org region to Logseq format and copy result to clipboard."
  (interactive "r")
  (let ((converted (self/org-region-to-logseq-string start end)))
    (kill-new converted)
    (message "Copied logseq format to clipboard")))

(global-set-key (kbd "C-x c l") #'self/org-to-logseq)
