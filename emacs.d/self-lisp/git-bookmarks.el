;; Bookmarking git repository snapshots

(require 'magit)
(require 's)

(defvar-local bookmark-suffix "-git-bookmark")

(defun stash-name (bookmark)
  (s-concat bookmark "-git-bookmark"))

;; (stash-name "test")

(defun bookmark-name (stash)
  (s-replace bookmark-suffix "" stash))

;; (bookmark-name "test-git-bookmark")

(defun git-bookmark-list ()
  "List all the created git bookmarks"
  ;; get all the git stash
  ;; git reflog  --pretty=format:"%gs" refs/stash --grep=git-bookmark
  (let* ((output (magit-git-lines "stash" "list" "--format=%gs" (concat "--grep=" bookmark-suffix)))
         (results (or output '())))
    (mapcar 'bookmark-name results)))

;; (git-bookmark-list)

