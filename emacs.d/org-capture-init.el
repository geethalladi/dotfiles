(require 'org-protocol)

;; Original Template
;; (setq org-capture-templates `(
;;   ("p" "Protocol" entry (file+headline, "~/Desktop/notes.org" "Notes")
;;         "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
;;   ("L" "Protocol Link" entry (file+headline, "~/Desktop/notes.org" "Notes")
;;         "* %? [[%:link][%(self/transform-square-brackets-to-round-ones \"%:description\")]]\n")))
(require 'org-protocol-capture-html)

(setq self--default-capture-file "~/Desktop/sticky-notes/captured.org")

(defun self--add-capture-templates ()
  "Add the templates needed for org-capture from firefox browser"

  (let* ((capture-file self--default-capture-file)
         (browser-capture-templates
          `(("p" "Protocol" entry (file+headline ,capture-file "Captured")
             "** %^{Title}\n\
Source: [[%:link][%:description]], %(progn (setq self/delete-frame-after-capture 2) \"\")\n\
Captured On: %u\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n"
             :empty-lines 1)
            ;; ("w" "Default template" entry (file+headline ,capture-file "Captured")
            ;;  "* %^{Title}\n\n  Source: %u, %c\n\n  %i"
            ;;  :empty-lines 1)
            ;; ("w" "Web site" entry
            ;;  (file+headline ,capture-file "Captured")
            ;;  "* %a :website:\n\n%U %?\n\n%:initial"
            ;;  :empty-lines 1)
            ("w" "Web site" entry
             (file+olp ,capture-file "Captured")
             "* %c :website:\n%U %?%:initial"
             :empty-lines 1)
            ("L" "Protocol Link" entry (file+headline ,capture-file "Captured")
             "** %?[[%:link][%:description]] %(progn (setq self/delete-frame-after-capture 2) \"\")\n\
Captured On: %u"
             :empty-lines 1))))

    (if (boundp 'org-capture-templates)
        ;; append to the list
        (setq org-capture-templates
              (append org-capture-templates browser-capture-templates))
      ;; create the variable
      (setq org-capture-templates browser-capture-templates))))

(self--add-capture-templates)

;; (defun self/transform-square-brackets-to-round-ones(string-to-transform)
;;   "Transforms [ into ( and ] into ), other chars left unchanged."
;;   (concat
;;   (mapcar #'(lambda (c) (if (equal c ?[) ?\( (if (equal c ?]) ?\) c))) string-to-transform)))

;; Kill the frame if one was created for the capture
(defvar self/delete-frame-after-capture 0 "Whether to delete the last frame after the current capture")

(defun self/delete-frame-if-neccessary (&rest r)
  (cond
   ((= self/delete-frame-after-capture 0) nil)
   ((> self/delete-frame-after-capture 1)
    (setq self/delete-frame-after-capture (- self/delete-frame-after-capture 1))
    (delete-frame))
   (t
    (setq self/delete-frame-after-capture 0)
    (delete-frame))))

(advice-add 'org-capture-finalize :after 'self/delete-frame-if-neccessary)
(advice-add 'org-capture-kill :after 'self/delete-frame-if-neccessary)
(advice-add 'org-capture-refile :after 'self/delete-frame-if-neccessary)
