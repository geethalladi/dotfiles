;; ENABLE CLIPBOARD
(setq x-select-enable-clipboard t)

(put 'erase-buffer 'disabled nil)

;; global clipetty mode
;; (global-clipetty-mode)

;; FOR INTEGRATING WITH CLIPBOARD
(defun swap-and-kill ()
  "Swap point and mark, then clipboard kill region"
  (interactive)
  (exchange-point-and-mark)
  (clipboard-kill-region (region-beginning) (region-end))
  (deactivate-mark))

(global-set-key "\C-w" 'swap-and-kill)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)

(require 'osx-clipboard)
(osx-clipboard-mode +1)

;; load the pbcopy.el file for integrating terminal emacs with clipboard
;; (load (expand-file-name "pbcopy.el" user-emacs-directory))

;; Because of the following "kill-line" hangs in the middle
;; Commenting out for OPTIMIZATION
;; Did not see any visible changes in behaviour
;; Would come back for further analysis when I observe any changes in behaviour

;; (defun copy-from-osx ()
;;   "Handle copy/paste intelligently on osx."
;;   (let ((pbpaste (purecopy "/usr/bin/pbpaste")))
;;     (if (and (eq system-type 'darwin)
;;              (file-exists-p pbpaste))
;;         (let ((tramp-mode nil)
;;               (default-directory "~"))
;;           (shell-command-to-string pbpaste)))))

;; (defun paste-to-osx (text &optional push)
;;   (let ((process-connection-type nil))
;;     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;;       (process-send-string proc text)
;;       (process-send-eof proc))))

;; (setq interprogram-cut-function 'paste-to-osx
;;       interprogram-paste-function 'copy-from-osx)
