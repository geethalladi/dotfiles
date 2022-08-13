;;
;; YAML mode configurations
;;
(require 'yaml-mode)

;; Required for yaml tree navigation
(require 'hydra)
(require 'indent-tools)

(defun self/yaml-mode-hook ()
  "Customization of yaml mode"
  (highlight-indentation-mode)
  (yafolding-mode)
  (define-key yaml-mode-map (kbd "C-c >") 'indent-tools-hydra/body))

;; (add-hook 'yaml-mode-hook 'highlight-indentation-mode)
;; (add-hook 'yaml-mode-hook 'yafolding-mode)

(add-hook 'yaml-mode-hook 'self/yaml-mode-hook)

;;
;; REST Client mode configurations
;;
(require 'company)
(require 'restclient)
(require 'company-restclient)

(add-to-list 'auto-mode-alist '("\\.\\(rest\\)$" . restclient-mode))
(add-to-list 'auto-mode-alist '("\\.\\(http\\)$" . restclient-mode))

(defun self/restclient-mode-hook ()
  (add-to-list 'company-backends 'company-restclient)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (smartparens-mode)
  (set (make-local-variable 'company-backends) '(company-restclient))
  (company-mode +1))

(add-hook 'restclient-mode-hook 'self/restclient-mode-hook)

;; Using json-mode for rest client responses
(add-to-list 'restclient-content-type-modes
             '("application/json" . json-mode))

;; (setq tab-always-indent nil)

(require 'markdown-mode)
;;
;;  Markdown mode configurations
;;
(defun self/markdown-mode ()
  "markdown mode customization"

  ;; markdown-mode binds "Esc-p" which conflicts with helm-projectile-find-file, so
  ;; unbind it.
  (local-unset-key (kbd "M-p"))

  (flyspell-mode 1)
  ;; Always use visual-line-mode
  (visual-line-mode 1))

(add-hook 'markdown-mode-hook 'self/markdown-mode)


;;
;;  Plantuml Configuration
;;
;; TODO: PlantUML configurations are in two places. Refactor !
(setq plantuml-jar-path
      (expand-file-name "vendor/org-mode/contrib/scripts/plantuml.jar" user-emacs-directory))
(setq plantuml-default-exec-mode 'jar)

(defun self/plantuml-mode ()
  "Plantuml mode customization"
  (smartparens-mode 1))

(add-hook 'plantuml-mode-hook 'self/plantuml-mode)

;;
;; TLA+ specification mode
(load-file
 (expand-file-name "vendor/tla-pcal-mode.el" user-emacs-directory))

;; info mode
(add-hook 'Info-mode-hook 'self/use-variable-width-font)

;; graphviz dot mode customizations
(use-package graphviz-dot-mode
  :ensure t
  :config
  (setq graphviz-dot-indent-width 4))

(use-package company-graphviz-dot)

;; editorconfig-mode
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;; from https://www.emacswiki.org/emacs/CopyingWholeLines
(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring.
      Ease of use features:
      - Move to start of next line.
      - Appends the copy on sequential calls.
      - Use newline as last char even on the last line of the buffer.
      - If region is active, copy its lines."
  (interactive "p")
  (let ((beg (line-beginning-position))
        (end (line-end-position arg)))
    (when mark-active
      (if (> (point) (mark))
          (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
        (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
    (if (eq last-command 'copy-line)
        (kill-append (buffer-substring beg end) (< end beg))
      (kill-ring-save beg end)))
  (kill-append "\n" nil)
  (beginning-of-line (or (and arg (1+ arg)) 2))
  (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))

(global-set-key (kbd "C-c d") 'copy-line)

;; Enable richer annotations using the Marginalia package
(use-package marginalia
  ;; Either bind `marginalia-cycle` globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  ;; The :init configuration is always executed (Not lazy!)
  :init
  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (progn
    (require 'marginalia)
    (marginalia-mode)))

;; bookmark+ for better bookmark UI
(add-to-list 'load-path
             (expand-file-name "vendor/bookmark-plus" user-emacs-directory))
(require 'bookmark+)

;; zeal integration
(require 'zeal-at-point)
(global-set-key (kbd "C-c C-d") 'zeal-at-point)

(require 'ag)

(add-to-list 'zeal-at-point-mode-alist
             '(python-mode . ("python3" "scipy" "numpy" "pandas" "sqlalchemy")))
(add-to-list 'zeal-at-point-mode-alist '(emacs-lisp-mode   . ("elisp")))
(add-to-list 'zeal-at-point-mode-alist '(shell-script-mode . ("bash")))
(add-to-list 'zeal-at-point-mode-alist '(ocaml-mode        . ("ocaml")))
(add-to-list 'zeal-at-point-mode-alist '(sql-mode          . ("sqlite" "mysql")))
(add-to-list 'zeal-at-point-mode-alist '(dockerfile-mode   . ("docker")))
(add-to-list 'zeal-at-point-mode-alist '(latex-mode        . ("latex")))

(setq yequake-frames
      '(("Yequake & scratch" .
         ((width . 0.75)
          (height . 0.5)
          (alpha . 0.95)
          (buffer-fns . ("~/Desktop/sticky-notes/notes.org"
                         split-window-horizontally
                         "~/Desktop/sticky-notes/meeting.org"))
          (frame-parameters . ((undecorated . t)))))))

(require 'sr-speedbar)

;; (use-package centaur-tabs
;;   :demand
;;   :config
;;   (setq centaur-tabs-cycle-scope 'tabs)
;;   (setq centaur-tabs-set-bar 'under)
;;   (setq centaur-tabs-set-close-button nil)
;;   (centaur-tabs-mode t)
;;   :bind
;;   ("C-c t b" . centaur-tabs-backward)
;;   ("C-c t n" . centaur-tabs-forward))

(require 'terraform-mode)
(require 'terraform-doc)

(require 'lua-mode)
