;; org agenda files
;; (setq org-agenda-files (quote ("~/Documents/personal/organiser")))

;; (defvar inbox-org-file )
;; (defvar gtd-org-file )
;; (defvar someday-org-file )
;; (defvar tickler-org-file )

;; Include emacs diary entries in org-agenda
(setq org-agenda-include-diary t)

(setq org-agenda-skip-scheduled-if-done t)

(setq org-default-notes-file "~/org/inbox.org")

;; Set the archive file and archive them under the heading "Finished Tasks"
(setq org-archive-location "tasks_archive.org::* Finished Tasks")

(setq org-agenda-files '("~/org/inbox.org"
                         "~/org/projects.org"
                         "~/org/tickler.org"
                         "~/org/recurring.org"
                         "~/org/references.org"))

(setq org-refile-targets '(("~/org/projects.org" :maxlevel . 2)
                           ("~/org/someday.org" :level . 1)
                           ("~/org/tickler.org" :maxlevel . 1)
                           ("~/org/recurring.org" :maxlevel . 1)
                           ("~/org/references.org" :maxlevel . 2)))

;; (setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
;; (setq org-refile-use-outline-path t)                  ; Show full paths for refiling

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/org/inbox.org" "Task Inbox")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/org/tickler.org" "Ticklers")
                               "* %i%? \n %U")))
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
