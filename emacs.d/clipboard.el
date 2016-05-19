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
