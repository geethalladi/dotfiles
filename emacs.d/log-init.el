;; reference - https://writequit.org/articles/working-with-logs-in-emacs.html#b-b-b-bonus
(use-package log4j-mode
  :ensure t
  :disabled t
  :init
  (add-hook #'log4j-mode-hook #'view-mode))

(defun self/use-log-font ()
  "set terminal style font"
   (interactive)
   (setq buffer-face-mode-face '(:family "Inconsolata" :height 180 :weight bold))
   (setq visual-fill-column-width 240)
   (setq line-spacing 0.5) ; add 0.5 height between lines
   ;; disable truncate lines by default
   (toggle-truncate-lines)
   (visual-line-mode)
   (buffer-face-mode))

(defun self/log4j-mode ()
  "Log4j customizations"
  (message "running log4j customizations")
  (view-mode)
  (read-only-mode)
  (self/use-log-font))

(add-hook 'log4j-mode-hook 'self/log4j-mode)

(defun self/update-java-logger-at-point ()
  (interactive)
  "Updating Java logger name at point"
  (self/change-word-or-region 'self/compressed-logger))

(defun self/compressed-logger (logger)
  "Update the java logger"
  (let* ((components (split-string logger "\\."))
         (package (butlast components))
         (packages (mapcar (lambda (xs) (substring xs 0 1)) package))
         (klass (last components))
         (result1 (append packages klass)))
     ;; (prin1 components)
     ;; (prin1 package)
     ;; (prin1 packages)
     ;; (prin1 klass)
     ;; (prin1 result1)
     (mapconcat 'identity result1 ".")))

(defun self/change-word-or-region (f)
  "Convert word at point (or selected region) by applying the function"
  (let* ((bounds (if (use-region-p)
      `               (cons (region-beginning) (region-end))
                   (bounds-of-thing-at-point 'symbol)))
         (text   (buffer-substring-no-properties (car bounds) (cdr bounds))))
    (when bounds
      (delete-region (car bounds) (cdr bounds))
      (insert (funcall f text)))))

(defun self/delete-unwanted-log-lines ()
  "delete unwanted log lines"
  (interactive)
  (flush-lines "HyperTrailClient")
  (flush-lines "hypertrail-ci")
  (flush-lines "/collector")
  (flush-lines "Doing nothing on node insert"))
