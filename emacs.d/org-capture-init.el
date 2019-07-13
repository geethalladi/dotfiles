;; (defun self/transform-square-brackets-to-round-ones(string-to-transform)
;;   "Transforms [ into ( and ] into ), other chars left unchanged."
;;   (concat
;;   (mapcar #'(lambda (c) (if (equal c ?[) ?\( (if (equal c ?]) ?\) c))) string-to-transform)))

;; (setq org-capture-templates `(
;;   ("p" "Protocol" entry (file+headline, "~/Desktop/notes.org" "Notes")
;;         "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
;;   ("L" "Protocol Link" entry (file+headline, "~/Desktop/notes.org" "Notes")
;;         "* %? [[%:link][%(self/transform-square-brackets-to-round-ones \"%:description\")]]\n")))

(require 'org-protocol)

(setq notes-directory "~/Desktop/notes/")

(setq org-capture-templates `(
  ("p" "Protocol" entry (file+headline ,(concat notes-directory "browser.org") "Notes")
   "* %^{Title}\nSource: [[%:link][%:description]], %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n"
   :empty-lines 1)
  ("L" "Protocol Link" entry (file+headline ,(concat notes-directory "browser.org") "Notes")
   "* %? [[%:link][%:description]] %(progn (setq self/delete-frame-after-capture 2) \"\")\nCaptured On: %u"
   :empty-lines 1)))

;; Kill the frame if one was created for the capture
(defvar self/delete-frame-after-capture 0 "Whether to delete the last frame after the current capture")

(defun self/delete-frame-if-neccessary (&rest r)
  (cond
   ((= self/delete-frame-after-capture 0) nil)
   ((> self/delete-frame-after-capture 1)
    (setq self/delete-frame-after-capture (- self/delete-frame-after-capture 1)))
   (t
    (setq self/delete-frame-after-capture 0)
    (delete-frame))))

(advice-add 'org-capture-finalize :after 'self/delete-frame-if-neccessary)
(advice-add 'org-capture-kill :after 'self/delete-frame-if-neccessary)
(advice-add 'org-capture-refile :after 'self/delete-frame-if-neccessary)
