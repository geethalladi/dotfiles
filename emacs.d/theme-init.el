;; Load theme after fonts, to override conflicting customisations in favour of theme
;; (use-package grandshell-theme)
;; (use-package soft-morning-theme)
;; (use-package solarized-theme)
;; (use-package spacemacs-theme)
;; (use-package spacegray-theme)
;; (use-package idea-darkula-theme)
(use-package monokai-theme)
(use-package zenburn-theme)

;; (use-package heroku-theme)
;; (use-package twilight-bright-theme)
;; (use-package zenburn-theme)

;; default themes
;; (load-theme 'zenburn t)
;; (load-theme 'github-modern t)
;; (load-theme 'wheatgrass t)
;; (load-theme 'monokai t)
;; (load-theme 'tango-dark t)
;; (load-theme 'heroku t)
;; (load-theme 'leuven t)

(defun self/-load-spacemacs-theme ()
  "Load spacemacs theme"
  (require 'spacemacs-dark-theme)
  (load-theme 'spacemacs-dark t))

(defun self/-load-heroku-theme ()
  "Customizing heroku theme"
  (load-theme 'heroku t)
  (self/-dark-theme-custom)
  ;; heroku-theme python
  ;; (set-face-background 'highlight-indentation-face "#3B4242")
  ;; (set-face-background 'highlight-indentation-current-column-face "#3B4242")

  ;; Powerline heroku theme
  (require 'powerline)
  (setq powerline-default-separator 'bar)
  (powerline-default-theme))

(defun self/-dark-modep ()
  "Check if emacs is started in dark context"
  ;; if the iterm profile contains the word dark
  ;; then return true
  (let ((profile (getenv "ITERM_PROFILE")))
    (or (and (stringp profile)
             (string-match-p (regexp-quote "dark") profile)) ;; if dark profile
        ;; os-theme-dark
        ;; (string= (self/-os-theme) "dark")
        )))

(defun self/-os-theme ()
  "Check the os theme"
  (let ((check-mac-theme
         "printf %s \"$( osascript -e \'tell application \"System Events\" to tell appearance preferences to return dark mode\' )\""))
    (if (string= (shell-command-to-string check-mac-theme) "true")
        "dark"
      "light")))

(defun self/-light-theme-custom ()
  "Custom theme for a light background"
  (custom-set-faces
   ;; Org mode faces
   '(org-level-1 ((t (:background "#ffffff"))))
   '(org-level-2 ((t (:background "#ffffff"))))
   '(org-level-3 ((t (:background "#ffffff"))))
   '(org-level-4 ((t (:background "#ffffff"))))
   '(org-level-5 ((t (:background "#ffffff"))))
   '(org-level-6 ((t (:background "#ffffff"))))
   '(org-level-7 ((t (:background "#ffffff"))))
   '(org-level-8 ((t (:background "#ffffff"))))

   ;; (face-remap-add-relative
   ;;  'mode-line '((:foreground "ivory" :background "Green4") mode-line))

   ;; helm
   '(helm-ff-file-extension ((t (:foreground "orange red"))))

   ;; rainbow delimiter mode
   '(rainbow-delimiters-depth-1-face ((t (:foreground "blue"))))
   '(rainbow-delimiters-depth-2-face ((t (:foreground "red"))))
   '(rainbow-delimiters-depth-3-face ((t (:foreground "green4"))))
   '(rainbow-delimiters-depth-4-face ((t (:foreground "black"))))
   '(rainbow-delimiters-depth-5-face ((t (:foreground "blue"))))
   '(rainbow-delimiters-depth-6-face ((t (:foreground "red"))))
   '(rainbow-delimiters-depth-7-face ((t (:foreground "green4"))))
   '(rainbow-delimiters-depth-8-face ((t (:foreground "black"))))

   '(rainbow-delimiters-unmatched-face ((t (:background "cyan"))))))

(defun self/-dark-theme-custom ()
  "Custom theme for a dark background"
  (set-face-attribute 'helm-selection nil
                      :background "green"
                      :foreground "black")
  (when (not (window-system))
    (set-frame-parameter (selected-frame) 'alpha '(85 85))
    (add-to-list 'default-frame-alist '(alpha 85 85)))

  (custom-set-faces
   ;; org mode faces
   '(org-level-1 ((t (:foreground "#dfaf8f"))))
   '(org-level-2 ((t (:foreground "#94bff3"))))
   '(org-level-3 ((t (:foreground "#e0cf9f"))))
   '(org-level-4 ((t (:foreground "#93e0e3"))))
   '(org-level-5 ((t (:foreground "#8fb28f"))))
   '(org-level-6 ((t (:foreground "#aeaeae"))))
   '(org-level-7 ((t (:foreground "#8c5353"))))
   '(org-level-8 ((t (:foreground "#4c7073"))))

   ;; org-table
   '(org-table ((t (:foreground "#7fa9ee"))))

   ;; helm
   '(helm-buffer-process ((t (:foreground "#dfaf8f"))))

   ;; irfc mode
   '(irfc-head-name-face ((t (:foreground "#ee3344"))))
   '(irfc-head-number-face ((t (:foreground "#dfaf8f"))))
   '(irfc-table-item-face ((t (:foreground "#94bff3"))))
   '(irfc-reference-face ((t (:foreground "#94bff3"))))

   ;; rainbow delimiter mode
   '(rainbow-delimiters-unmatched-face ((t (:foreground "#ee3344"))))
   '(rainbow-delimiters-depth-1-face ((t (:foreground "#dfaf8f"))))
   '(rainbow-delimiters-depth-2-face ((t (:foreground "#94bff3"))))
   '(rainbow-delimiters-depth-3-face ((t (:foreground "#e0cf9f"))))
   '(rainbow-delimiters-depth-4-face ((t (:foreground "#93e0e3"))))
   '(rainbow-delimiters-depth-5-face ((t (:foreground "#8fb28f"))))
   '(rainbow-delimiters-depth-6-face ((t (:foreground "#dfaf8f"))))
   '(rainbow-delimiters-depth-7-face ((t (:foreground "#94bff3"))))
   '(rainbow-delimiters-depth-8-face ((t (:foreground "#e0cf9f"))))

   ;; smartparens-mode
   '(sp-show-pair-mismatch-face ((t (:foreground "#ee3344"))))
   '(sp-show-pair-match-face ((t (:background "#6F6F6F"))))

   ;; magit
   '(magit-diff-added-highlight ((t (:foreground "#151515"))))

   ;; log4j mode
   '(log4j-font-lock-keywords ((t (:foreground "#dfaf8f"))))
   '(log4j-font-lock-error-face ((t (:foreground "#ff4500"))))
   '(log4j-font-lock-warn-face ((t (:foreground "#e0cf9f"))))
   '(log4j-font-lock-info-face ((t (:foreground "#93e0e3"))))
   '(log4j-font-lock-debug-face ((t (:foreground "#8fb28f"))))
   '(log4j-font-lock-fatal-face ((t (:foreground "#aeaeae"))))
   '(log4j-font-lock-config-face ((t (:foreground "#8c5353"))))
   ;; '(log4j-font-lock- ((t (:foreground "#4c7073"))))

   ;; scheme / quack
   '(quack-pltish-comment-face ((t (:foreground "#aeaeae"))))
   '(quack-pltish-defn-face ((t (:foreground "#dfaf8f"))))))

(defun self/-less-bright-theme-custom ()
  "Custom settings for a less bright theme"
  (custom-set-faces
   ;; org mode faces theme
   ;; replacing with better variants from
   ;; https://en.wikipedia.org/wiki/Solarized
   '(org-level-2 ((t (:foreground "#2aa198"))))
   '(org-level-3 ((t (:foreground "#b58900"))))
   '(org-level-4 ((t (:foreground "#268bd2"))))
   '(org-level-5 ((t (:foreground "#cb4b16"))))

   ;; smartparens theme
   '(sp-show-pair-mismatch-face ((t (:foreground "#ee3344"))))
   '(sp-show-pair-match-face ((t (:background "#E0C0C0"))))

   ;; rainbow delimiter themes
   '(rainbow-delimiters-depth-1-face ((t (:foreground "blue"))))
   '(rainbow-delimiters-depth-2-face ((t (:foreground "black"))))
   '(rainbow-delimiters-depth-3-face ((t (:foreground "orange2"))))
   '(rainbow-delimiters-depth-4-face ((t (:foreground "green4"))))
   '(rainbow-delimiters-depth-5-face ((t (:foreground "blue"))))
   '(rainbow-delimiters-depth-6-face ((t (:foreground "black"))))
   '(rainbow-delimiters-depth-7-face ((t (:foreground "orange2"))))
   '(rainbow-delimiters-depth-8-face ((t (:foreground "green4"))))
   '(rainbow-delimiters-unmatched-face ((t (:background "cyan"))))))

(defun self/load-less-bright-theme ()
  "less bright theme"
  (interactive)
  (use-package solarized
    :ensure solarized-theme
    :defer t
    :init
    (defun self/solarized-theme-hook ()
      (set-face-attribute 'font-lock-constant-face nil :weight 'normal)
      (set-face-attribute 'font-lock-function-name-face nil :weight 'bold)
      (set-face-attribute 'which-key-key-face nil :foreground
                          (face-attribute 'error :foreground)))
    :config
    (setq solarized-use-variable-pitch nil
          solarized-use-less-bold t
          solarized-use-more-italic nil
          solarized-distinct-doc-face t
          solarized-high-contrast-mode-line t
          solarized-height-minus-1 1.0
          solarized-height-plus-1 1.0
          solarized-height-plus-2 1.0
          solarized-height-plus-3 1.0
          solarized-height-plus-4 1.0))
  (require 'solarized)
  (load-theme 'solarized-selenized-light t)
  (self/-less-bright-theme-custom))

(defun self/load-light-theme ()
  "light theme"
  (interactive)
  (require 'leuven-theme)
  (load-theme 'leuven t)
  (self/-light-theme-custom))

(defun disable-all-themes ()
  "disable all active themes."
  (dolist (i custom-enabled-themes)
    (disable-theme i)))

(defadvice load-theme (before disable-themes-first activate)
  "Calling disable all themes before loading a new one"
  (disable-all-themes))

(defun self/-inside-screenp ()
  "Predicate to check if running inside screen"
  ;; TODO: should grep for screen inside TERMCAP
  (and (not (window-system))
       (or (stringp (getenv "TERMCAP"))
           (stringp (getenv "TMUX")))))

(defun self/load-dark-theme ()
  "dark theme"
  (interactive)
  ;; (self/-load-spacemacs-theme)
  (load-theme 'zenburn t)
  ;; (load-them 'heroku t)
  (self/-dark-theme-custom))

(defun self/reload-theme ()
  "Load theme as per the environment"
  (interactive)
  (cond
   ;; skip inside screen
   ((and (self/-inside-screenp)
         (self/-dark-modep))
    ;; (message "Skipping loading dark theme inside screen")
    (self/load-dark-theme))
   ;; if dark-mode if true, use it
   ((self/-dark-modep) (self/load-dark-theme))
   ;; else in window system
   ;; ((window-system) (self/load-light-theme))
   ;; fall back to light
   ;; (t (self/load-less-bright-theme))
   ;; (t (self/load-light-theme))
   (t (self/load-dark-theme))
   ))

(self/reload-theme)

(setq self/hi-lock-patterns
      '(("@@" (0 'hi-green t))
  ("!!" (0 'hi-salmon t))
  ("??" (0 'hi-yellow t))))
(font-lock-add-keywords nil self/hi-lock-patterns t)
(font-lock-flush)
(global-hi-lock-mode 1)
