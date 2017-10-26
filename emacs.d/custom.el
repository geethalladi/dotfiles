;; Half page scrolling

(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))

(defun scroll-up-half ()
  (interactive)
  (scroll-up (window-half-height)))

(defun scroll-down-half ()
  (interactive)
  (scroll-down (window-half-height)))

(global-set-key (kbd "s-<up>") 'scroll-down-half)
(global-set-key (kbd "s-<down>") 'scroll-up-half)

(global-set-key (kbd "C-x <up>") 'scroll-down-half)
(global-set-key (kbd "C-x <down>") 'scroll-up-half)

;; Multiple Cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(require 'smartparens-config)

;; For associating pomodoro with lisp mode
(add-to-list 'auto-mode-alist '("\\.pomo" . lisp-mode))

(setenv "LC_CTYPE" "UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LANG" "en_US.UTF-8")


;; Elastic Search mode
(add-to-list 'auto-mode-alist '("\\.es$" . es-mode))
(add-hook 'es-result-mode-hook 'hs-minor-mode)

(defvar es-default-base "http://localhost:9200")
(defvar nginx-indent-level 2)

;; C-h for delete-backward-char
;; (global-set-key [(control ?h)] 'delete-backward-char)

;; Get all the environment variables from shell
(exec-path-from-shell-copy-env "PYTHONPATH")
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Setting key for global multiple cursor mode
(global-set-key (kbd "C-c m c") 'mc/edit-lines)

;; '(custom-safe-themes
;;   (quote
;;    ("e14f8791b180b69f95550ae9fb6b3fa2321115197908f0a8a2cd924bd5acc86f"
;;     "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0"
;;     "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4"
;;     "19352d62ea0395879be564fc36bc0b4780d9768a964d26dfae8aad218062858d"
;;     default)))
;; '(ecb-layout-window-sizes
;;   (quote
;;    (("left8"
;;      (ecb-directories-buffer-name 0.27722772277227725 . 0.2962962962962963)
;;      (ecb-sources-buffer-name 0.27722772277227725 . 0.24074074074074073)
;;      (ecb-methods-buffer-name 0.27722772277227725 . 0.25925925925925924)
;;      (ecb-history-buffer-name 0.27722772277227725 . 0.18518518518518517)))))
;; '(ecb-options-version "2.40")
