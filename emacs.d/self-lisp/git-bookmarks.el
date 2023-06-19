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
  ;; git reflog  --pretty=format:"%gs" refs/stash --grep=git-bookmark
  (let* ((output (magit-git-lines "stash" "list" "--format=%gs" (concat "--grep=" bookmark-suffix)))
         (results (or output '())))
    (mapcar 'bookmark-name results)))

(defun git-bookmark-ref (bookmark)
  "Return the stash reference of the given bookmark"
  ;; TODO
  nil)

(defun git-bookmark-create (bookmark)
  "Create a bookmark with the current snapshot"
  ;; TODO: delete an already existing bookmark
  ;; create a stash (git stash -u) with the given name
  (let* ((name (stash-name bookmark)))
    (magit-stash-both name t)))

(defun git-bookmark-delete (bookmark)
  "Delete the bookmark with the given name"
  ;; TODO: remove the stash reference with the given name
)

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
)
