;; Bookmarking git repository snapshots

(require 'magit)
(require 's)

(defvar-local bookmark-suffix "-git-bookmark")

(defun stash-name (bookmark)
  (s-concat bookmark "-git-bookmark"))

(defun bookmark-name (stash)
  (s-replace bookmark-suffix "" stash))

(defun git-bookmark-list ()
  "List all the created git bookmarks"
  ;; git reflog --pretty=format:"%gs" refs/stash --grep=git-bookmark
  (let* ((output (magit-git-lines "stash" "list" "--format=%gs" (concat "--grep=" bookmark-suffix)))
         (results (or output '())))
    (mapcar 'bookmark-name results)))

(defun git-bookmark-ref (bookmark)
  "Return the stash reference of the given bookmark"
  (let* ((output (magit-git-lines
                  "reflog" "--pretty=format:%gD" "refs/stash" (concat "--grep=" bookmark bookmark-suffix)))
         (results (or output '())))
    (car results)))

(defun git-bookmark-create (bookmark)
  "Create a bookmark with the current snapshot"
  ;; TODO: delete an already existing bookmark
  ;; create a stash (git stash -u) with the given name
  (let* ((name (stash-name bookmark)))
    (git-bookmark-delete bookmark)
    (magit-stash-both name t)))

(defun git-bookmark-delete (bookmark)
  "Delete the bookmark with the given name"
  ;; git stash drop refs/stash@{1}
  (let* ((ref (git-bookmark-ref bookmark)))
    (if ref
        (magit-git-lines "stash" "drop" ref))))

(defun has-file-changes-p ()
  "Check if there are any files changes"
  ;; git status -s
  (not (null (magit-git-lines "status" "-s"))))

(defun switch-to-main-branch ()
  "Switch the main branch"
  ;; (magit-branch-checkout (magit-main-branch))
  (magit-branch-checkout (magit-git-string "main")))

(defun git-bookmark-save ()
  "Save the current state as a bookmark"
  (interactive)
  (if (has-file-changes-p)
      (let* ((branch (magit-get-current-branch))
             (bookmark (bookmark-name branch)))
        (git-bookmark-create bookmark)
        (message "switching to main branch")
        (switch-to-main-branch))
    (message "No changes to save")))

(defun git-bookmark-switch (bookmark)
  "Switch to the mentioned git-bookmark"
  (if (has-file-changes-p)
      (message "Save the work before switching")
    ;; else
    ;; switch the branch
    ;; remove the stash entry
    ;; git stash apply stash^{/say-my-name}
    ;; post switch delete the bookmark
    (let* ((branch bookmark)
           (stash (stash-name bookmark))
           (stash-ref (git-bookmark-ref bookmark))
           (stash-bookmark-name (format "stash^{/%s}" stash)))
      (message (format "Switching to git-bookmark %s" stash-bookmark-name))
      (magit-branch-checkout branch)
      (message "output: %s" (magit-git-lines "stash" "apply" stash-ref))
      (git-bookmark-delete bookmark))))

;; creating helm source

(defun helm-git-bookmark ()
  "Invoke helm git bookmark"
  (interactive)
  (setq git-bookmark-helm-source
        '((name . "Git bookmarks")
          (candidates . git-bookmark-list)
          (volatile)
          (action . git-bookmark-switch)))
  (helm :sources '(git-bookmark-helm-source)))

;; creating key bindings

(global-unset-key (kbd "C-c b"))

(global-set-key (kbd "C-c b l") 'helm-git-bookmark)

(global-set-key (kbd "C-c b s") 'git-bookmark-save)
