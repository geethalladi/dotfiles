;; org agenda files
;; (setq org-agenda-files (quote ("~/Documents/personal/organiser")))

;; (defvar inbox-org-file )
;; (defvar gtd-org-file )
;; (defvar someday-org-file )
;; (defvar tickler-org-file )

;; Include emacs diary entries in org-agenda

(defconst self/agenda-inbox "~/org/inbox.org" "Org Agenda Inbox file")
(defconst self/agenda-project "~/org/projects.org" "Org Agenda Project file")
(defconst self/agenda-tickler "~/org/tickler.org" "Org Agenda Tickler file")
(defconst self/agenda-recurring "~/org/recurring.org" "Org Agenda Recurring file")
(defconst self/agenda-waiting "~/org/waiting.org" "Org Agenda Waiting file")
(defconst self/agenda-archive "tasks_archive.org" "Org Agenda Archive file")
(defconst self/agenda-dayjob "~/org/dayjob.org" "Org Agenda Dayjob file")
(defconst self/agenda-this-week "~/org/this-week.org" "Org Agenda this week file")

(defun self--add-agenda-templates ()
  "add the templates required for org-agenda"
  (let ((agenda-templates
         `(("t" "Todo [inbox]" entry
            (file+headline ,self/agenda-inbox "Task Inbox")
            "* TODO %i%?")
           ("T" "Tickler" entry
            (file+headline ,self/agenda-tickler "Ticklers")
            "* %i%? \n %U"))))

    (if (boundp 'org-capture-templates)
        ;; append to the list
        (setq org-capture-templates
              (append org-capture-templates agenda-templates))
      ;; create the variable
      (setq org-capture-templates agenda-templates))))

(setq org-agenda-include-diary t)

(setq org-agenda-skip-scheduled-if-done t)

(setq org-agenda-skip-unavailable-files t)

(setq org-default-notes-file 'self/agenda-inbox)

;; Set the archive file and archive them under the heading "Finished Tasks"
(setq org-archive-location "tasks_archive.org::* Finished Tasks")

(setq org-agenda-files (list self/agenda-inbox
                             self/agenda-project
                             self/agenda-tickler
                             self/agenda-recurring
                             self/agenda-dayjob
                             self/agenda-this-week))

(setq org-refile-targets `((,self/agenda-project :maxlevel . 2)
                           (,self/agenda-dayjob :maxlevel . 2)
                           (,self/agenda-waiting :level . 1)
                           (,self/agenda-tickler :maxlevel . 1)
                           (,self/agenda-this-week :maxlevel . 1)
                           (,self/agenda-recurring :maxlevel . 1)))

;; (setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
;; (setq org-refile-use-outline-path t)                  ; Show full paths for refiling

(self--add-agenda-templates)

(setq org-todo-keywords
      '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

(define-key global-map "\C-cc" 'org-capture)

(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))

(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (org-current-is-todo)
          (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
          (goto-char (point-max))))))

(setq org-agenda-custom-commands
      (quote (("o" "At the office" tags-todo "@office"
               ((org-agenda-overriding-header "Office")
                (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
              ("h" "At Home" tags-todo "@home"
               ((org-agenda-overriding-header "Home")
                (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first))))))
