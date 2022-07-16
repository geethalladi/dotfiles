;; epub mode
(require 'nov)

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(add-hook 'nov-mode-hook 'self/nov-font-setup)
(add-hook 'nov-post-html-render-hook 'self/nov-post-html-render-hook)

(load (expand-file-name "vendor/justify-kp.el" user-emacs-directory))

(defun self/nov-font-setup ()
  (message "Setting up nov font")
  (setq nov-text-width 70)
  (setq visual-fill-column-center-text t)
  (visual-line-mode t)
  (visual-fill-column-mode t)
  (linum-mode 0)
  (hl-highlight-mode t)
  (face-remap-add-relative 'variable-pitch :family "Consolas"
                           :height 1.0))

(defun self/nov-window-configuration-change-hook ()
  (self/nov-post-html-render-hook)
  (remove-hook 'window-configuration-change-hook
               'self/nov-window-configuration-change-hook
               t))

(defun self/nov-post-html-render-hook ()
  (if (get-buffer-window)
      (let ((max-width (pj-line-width))
            buffer-read-only)
        (save-excursion
          (goto-char (point-min))
          (while (not (eobp))
            (when (not (looking-at "^[[:space:]]*$"))
              (goto-char (line-end-position))
              (when (> (shr-pixel-column) nov-text-width)
                (goto-char (line-beginning-position))
                (pj-justify)))
            (forward-line 1))))

    (add-hook 'window-configuration-change-hook
              'self/nov-window-configuration-change-hook
              nil t)))
