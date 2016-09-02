;; ENABLE CLIPBOARD
(setq x-select-enable-clipboard t)

(put 'erase-buffer 'disabled nil)

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

;; load the pbcopy.el file for integrating terminal emacs with clipboard
(load "~/.emacs.d/pbcopy.el")

(require 'pbcopy)
(turn-on-pbcopy)

(defun copy-from-osx ()
  "Handle copy/paste intelligently on osx."
  (let ((pbpaste (purecopy "/usr/bin/pbpaste")))
    (if (and (eq system-type 'darwin)
             (file-exists-p pbpaste))
        (let ((tramp-mode nil)
              (default-directory "~"))
          (shell-command-to-string pbpaste)))))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx
      interprogram-paste-function 'copy-from-osx)
