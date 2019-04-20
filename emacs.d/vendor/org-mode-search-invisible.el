;; Code obtained from stackoverflow
;; https://emacs.stackexchange.com/questions/21208/search-and-replace-invisible-url-link-in-org-mode

(defvar-local org-descriptive-links-isearch nil
  "Backup of the original value `org-descriptive-links' before isearch.")

(defun org-isearch-mode-hook-function ()
  "Save value of `org-descriptive-links' before isearch."
  (setq org-descriptive-links-isearch org-descriptive-links))

(defun org-isearch-mode-end-hook-function ()
  "Restore original value of `org-descriptive-links' after isearch."
  (unless (eq org-descriptive-links-isearch org-descriptive-links)
    (org-toggle-link-display)))

(defun org-mode-isearch-filter (found)
  "Toggle to literal links if match is found within a string that is hidden in the target of descriptive links."
  (when (and found
         (text-property-any (match-beginning 0) (match-end 0) 'invisible 'org-link)
         org-descriptive-links)
    (org-toggle-link-display))
  found)

(defun org-query-replace-isearch-wrapper (oldfun &rest args)
  "Toggle to literal links if match is found within a string that is hidden in the target of descriptive links."
  (org-isearch-mode-hook-function)
  (prog1 (apply oldfun args)
    (org-isearch-mode-end-hook-function)))

(defun org-mode-setup-isearch ()
  "Setup some specials for isearch in org-mode.
   1. Toggle descriptive links if necessary."
  (setq-local search-invisible t)
  (add-hook 'isearch-mode-hook 'org-isearch-mode-hook-function)
  (add-hook 'isearch-mode-end-hook 'org-isearch-mode-end-hook-function)
  (add-function :filter-return (local 'isearch-filter-predicate) #'org-mode-isearch-filter)
  (advice-add 'query-replace :around #'org-query-replace-isearch-wrapper)
  (advice-add 'query-replace-regexp :around #'org-query-replace-isearch-wrapper))

(add-hook 'org-mode-hook 'org-mode-setup-isearch)
