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
