;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "user"
      user-mail-address "user@not-configured.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-font
      (font-spec :family "Jetbrains Mono" :size 16
                 :weight 'normal))

;; (setq doom-theme 'doom-snazzy)
;; (setq doom-theme 'doom-vibrant)
;; (setq doom-theme 'doom-opera-light)
;; (setq doom-theme 'doom-zenburn)
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-nord)
;; (setq doom-theme 'doom-solarized)
;; (setq doom-theme 'doom-solarized-light)
;; (setq doom-theme 'doom-acario-light)

(setq doom-theme 'doom-spacegrey)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/work/docs/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq cursor-type 'box)
(set-cursor-color "#ffffff")

(osx-clipboard-mode)

(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(setq auto-window-vscroll nil)
(setq display-line-numbers-type nil)

;; (setq lsp-java-jdt-download-url
;;       "https://download.eclipse.org/jdtls/milestones/0.57.0/jdt-language-server-0.57.0-202006172108.tar.gz")

;; (setq lsp-java-vmargs
;;       '("-noverify" "-Xmx3G" "-XX:+UseG1GC" "-XX:+UseStringDeduplication"
;;         "-javaagent:/Users/galladi/.m2/repository/org/projectlombok/lombok/1.18.20/lombok-1.18.20.jar"
;;         "-Xbootclasspath/a:/Users/galladi/.m2/repository/org/projectlombok/lombok/1.18.20/lombok-1.18.20.jar"))

;; (use-package lsp-mode
;;   :commands lsp
;;   :ensure t
;;   :diminish lsp-mode
;;   :hook
;;   (elixir-mode . lsp)
;;   :init
;;   (add-to-list 'exec-path "/Users/galladi/installed.d/lsp/elixir"))

(defun export-to-html-and-open ()
  "Export to html and open in default browser"
  (interactive)
  (browse-url-of-file
   (org-html-export-to-html)))

;; centaur tabs
(global-set-key (kbd "C-c t n") 'centaur-tabs-forward)
(global-set-key (kbd "C-c t b")  'centaur-tabs-backward)

;; magit
(global-set-key (kbd "C-c g s")  'magit-status)

;; projectile
(map! :map 'override "M-p" 'projectile-find-file)

;; code folding
(map! :map 'override "M-RET" '+fold/toggle)

;; editor navigation
(map! :map 'override "M-<right>" 'right-word)
(map! :map 'override "M-<left>" 'left-word)
(map! :map 'override "S-<right>" 'windmove-right)
(map! :map 'override "S-<left>" 'windmove-left)

;; key chord + file navigation
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "jk" 'switch-to-prev-buffer)

;; neotree
(global-set-key (kbd "<f8>") #'neotree)

(setq-default line-spacing 0.12)

(after! ruby-mode
        (map! :map ruby-mode-map "C-c j" 'robe-jump)
        (map! :map ruby-mode-map "C-c C-j" 'yas-expand)
        ;; (map! :map 'override (kbd "TAB") 'tab-indent-or-complete)
        ;; (global-set-key [tab] 'tab-indent-or-complete)
        ;; (global-set-key (kbd "TAB") 'tab-indent-or-complete)
        ;; (global-set-key [(control return)] 'company-complete-common)
        (map! :map ruby-mode-map [tab] 'tab-indent-or-complete)
        (map! :map ruby-mode-map [(control return)] 'company-complete-common)
        ;; (setq-hook! 'ruby-mode-hook
        ;;             +lsp-company-backends
        ;;             '(company-capf company-yasnippet
        ;;                            company-robe company-etags
        ;;                            company-dabbrev company-dabbrev-code company-ispell))
        (setq-default tab-width 2)
        (set-company-backend! 'ruby-mode
                              '(company-yasnippet
                                company-dabbrev-code
                                company-robe
                                company-etags
                                company-capf)))

;; (require 'lsp-sonarlint)
;; (require 'lsp-sonarlint-java)
;; (setq lsp-sonarlint-java-enabled t)

;; (use-package! copilot
;;   :hook (prog-mode . copilot-mode)
;;   :bind (:map copilot-completion-map
;;               ("<tab>" . 'copilot-accept-completion)
;;               ("TAB" . 'copilot-accept-completion)
;;               ("C-TAB" . 'copilot-accept-completion-by-word)
;;               ("C-<tab>" . 'copilot-accept-completion-by-word)))

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(require 'robe)
(require 'rspec-mode)
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'ruby-mode-hook 'rspec-mode)

(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

(global-company-mode t)

(require 'yasnippet)
(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
    (backward-char 1)
    (if (looking-at "->") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (cond
   ((minibufferp)
    (minibuffer-complete))
   (t
    (indent-for-tab-command)
    (if (or (not yas/minor-mode)
        (null (do-yas-expand)))
    (if (check-expansion)
        (progn
          (company-manual-begin)
          (if (null company-candidates)
          (progn
            (company-abort)
            (indent-for-tab-command)))))))))

(defun tab-complete-or-next-field ()
  (interactive)
  (if (or (not yas/minor-mode)
      (null (do-yas-expand)))
      (if company-candidates
      (company-complete-selection)
    (if (check-expansion)
      (progn
        (company-manual-begin)
        (if (null company-candidates)
        (progn
          (company-abort)
          (yas-next-field))))
      (yas-next-field)))))

(defun expand-snippet-or-complete-selection ()
  (interactive)
  (if (or (not yas/minor-mode)
      (null (do-yas-expand))
      (company-abort))
      (company-complete-selection)))

(defun abort-company-or-yas ()
  (interactive)
  (if (null company-candidates)
      (yas-abort-snippet)
    (company-abort)))

(define-key company-active-map [tab] 'expand-snippet-or-complete-selection)
(define-key company-active-map (kbd "TAB") 'expand-snippet-or-complete-selection)

(define-key yas-minor-mode-map [tab] nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)

(define-key yas-keymap [tab] 'tab-complete-or-next-field)
(define-key yas-keymap (kbd "TAB") 'tab-complete-or-next-field)
(define-key yas-keymap [(control tab)] 'yas-next-field)
(define-key yas-keymap (kbd "C-g") 'abort-company-or-yas)

(require 'projectile-rails)
(define-key projectile-rails-mode-map (kbd "C-c r") 'projectile-rails-command-map)
