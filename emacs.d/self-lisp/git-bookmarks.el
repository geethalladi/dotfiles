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
  ;; TODO
  t)

(defun git-bookmark-save ()
  "Save the current state as a bookmark"
  ;; save only if there are file changes
  (if (has-file-changes-p)
      (let* ((branch (magit-get-current-branch))
             (bookmark (bookmark-name branch)))
        (git-bookmark-create bookmark))))

(defun git-bookmark-switch (bookmark)
  ;; TODO: switch to the bookmark
  ;; switch the branch
  ;; apply the stash
  ;; remove the stash entry
  ;; git stash apply stash^{/say-my-name}
  (message (format "Switching to git-bookmark %s" bookmark)))

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

(global-set-key (kbd "C-c g b") 'helm-git-bookmark)

