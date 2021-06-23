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
(setq plantuml-jar-path "~/.emacs.d/vendor/org-mode/contrib/scripts/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)

(defun self/plantuml-mode ()
  "Plantuml mode customization"
  (smartparens-mode 1))

(add-hook 'plantuml-mode-hook 'self/plantuml-mode)

;;
;; TLA+ specification mode

(load-file "~/dotfiles/emacs.d/vendor/tla-pcal-mode.el")

;;
;; adoc-mode
;;
(defun self/adoc-mode ()
  "adoc-mode specifications"
  (buffer-face-mode t)
  (self/use-variable-width-font))

(add-hook 'adoc-mode-hook 'self/adoc-mode)

(add-to-list 'auto-mode-alist '("\\.\\(adoc\\|asciidoc\\|txt\\)$" . adoc-mode))
