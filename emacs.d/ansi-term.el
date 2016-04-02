;; term mode

(setq comint-prompt-read-only t)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)

;; (require 'ansi-term)

;; Default shell for ansi-term
(setq explicit-shell-file-name "/bin/zsh")
;; (setq ansi-term-program "/bin/zsh")

(add-hook 'term-mode-hook
          (lambda ()
            (setq term-buffer-maximum-size 20000)))

(add-hook 'term-mode-hook
          (lambda ()
            (setq show-trailing-whitespace nil)))

(defcustom term-unbind-key-list
  '("C-z" "C-x" "C-c" "C-h" "C-y" "<ESC>")
  "The key list that will need to be unbind."
  :type 'list
  :group 'multi-term)

(when (require 'term nil t) ; only if term can be loaded..
  (setq term-bind-key-alist
        (list (cons "C-c C-c" 'term-interrupt-subjob)
              (cons "C-c C-j" 'term-line-mode)
              (cons "C-c C-k" 'term-char-mode)
              (cons "M-r" 'term-send-reverse-search-history)
              (cons "C-p" 'previous-line)
              (cons "C-n" 'next-line)
              (cons "C-s" 'isearch-forward)
              (cons "C-r" 'isearch-backward)
              (cons "M-f" 'term-send-forward-word)
              (cons "M-b" 'term-send-backward-word)
              (cons "M-DEL" 'term-send-backward-kill-word)
              (cons "M-d" 'term-send-forward-kill-word)
              (cons "<C-left>" 'term-send-backward-word)
              (cons "<C-right>" 'term-send-forward-word)
              (cons "C-r" 'term-send-reverse-search-history)
              (cons "M-p" 'term-send-raw-meta)
              (cons "M-y" 'term-send-raw-meta)
              (cons "M-o" 'term-send-backspace)
              (cons "M-," 'term-send-input)
              (cons "M-." 'comint-dynamic-complete)
              (cons "C-y" 'term-send-raw))))

;;   "The key alist that will need to be bind.
;; If you do not like default setup, modify it, with (KEY . COMMAND) format."
;;   :type 'alist
;;   :group 'multi-term)

(add-hook 'term-mode-hook
          (lambda ()
            (add-to-list 'term-bind-key-alist '("M-[" . ansi-term-prev))
            (add-to-list 'term-bind-key-alist '("M-]" . ansi-term-next))))

(add-hook 'term-mode-hook
          (lambda () (define-key term-raw-map (kbd "C-y") 'term-paste)))

(add-hook 'term-mode-hook
          (lambda () (define-key term-raw-map (kbd "s-v") 'term-paste)))

(when (require 'term nil t)
  (defun term-handle-ansi-terminal-messages (message)
    (while (string-match "\eAnSiT.+\n" message)
      ;; Extract the command code and the argument.
      (let* ((start (match-beginning 0))
             (command-code (aref message (+ start 6)))
             (argument
              (save-match-data
                (substring message
                           (+ start 8)
                           (string-match "\r?\n" message
                                         (+ start 8))))))
        ;; Delete this command from MESSAGE.
        (setq message (replace-match "" t t message))

        (cond ((= command-code ?c)
               (setq term-ansi-at-dir argument))
              ((= command-code ?h)
               (setq term-ansi-at-host argument))
              ((= command-code ?u)
               (setq term-ansi-at-user argument))
              ((= command-code ?e)
               (save-excursion
                 (find-file-other-window argument)))
              ((= command-code ?x)
               (save-excursion
                 (find-file argument))))))

    (when (and term-ansi-at-host term-ansi-at-dir term-ansi-at-user)
      (setq buffer-file-name
            (format "%s@%s:%s" term-ansi-at-user term-ansi-at-host term-ansi-at-dir))
      (set-buffer-modified-p nil)
        (setq default-directory (if (string= term-ansi-at-host (system-name))
                                    (concatenate 'string term-ansi-at-dir "/")
                                  (format "/%s@%s:%s/" term-ansi-at-user term-ansi-at-host term-ansi-at-dir))))
    message))

;; term
;; Using zenburn defaults
;; '(term-color-black ((t (:foreground ,zenburn-bg
;;                                     :background ,zenburn-bg-1))))
;; '(term-color-red ((t (:foreground ,zenburn-red-2
;;                                   :background ,zenburn-red-4))))
;; '(term-color-green ((t (:foreground ,zenburn-green
;;                                     :background ,zenburn-green+2))))
;; '(term-color-yellow ((t (:foreground ,zenburn-orange
;;                                      :background ,zenburn-yellow))))
;; '(term-color-blue ((t (:foreground ,zenburn-blue-1
;;                                    :background ,zenburn-blue-4))))
;; '(term-color-magenta ((t (:foreground ,zenburn-magenta
;;                                       :background ,zenburn-red))))
;; '(term-color-cyan ((t (:foreground ,zenburn-cyan
;;                                    :background ,zenburn-blue))))
;; '(term-color-white ((t (:foreground ,zenburn-fg
;;                                     :background ,zenburn-fg-1))))
;; '(term-default-fg-color ((t (:inherit term-color-white))))
;; '(term-default-bg-color ((t (:inherit term-color-black))))

(eval-after-load "term"
  '(progn
     (define-key term-raw-map (kbd "<M-left>")
       (lambda () (interactive) (term-send-raw-string "\eb")))
     (define-key term-raw-map (kbd "<M-right>")
       (lambda () (interactive) (term-send-raw-string "\ef")))
     ))
