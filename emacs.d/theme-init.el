;; Load theme after fonts, to override conflicting customisations in favour of theme

;; default themes
;; (load-theme 'zenburn t)
;; (load-theme 'github-modern t)
;; (load-theme 'wheatgrass t)
;; (load-theme 'monokai t)
;; (load-theme 'tango-dark t)
;; (load-theme 'heroku t)
;; (load-theme 'leuven t)

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
        (string= (self/-os-theme) "dark"))))

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

   ;; scheme / quack
   '(quack-pltish-comment-face ((t (:foreground "#aeaeae"))))
   '(quack-pltish-defn-face ((t (:foreground "#dfaf8f"))))))

(defun self/-less-bright-theme-custom ()
  "Custom settings for a less bright theme"
  (custom-set-faces
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
  (load-theme 'solarized-light t)
  (self/-less-bright-theme-custom))

(defun self/load-light-theme ()
  "light theme"
  (interactive)
  (load-theme 'leuven t)
  (self/-light-theme-custom))

(defun self/load-dark-theme ()
  "dark theme"
  (interactive)
  (load-theme 'zenburn t)
  (self/-dark-theme-custom))

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
       (stringp (getenv "TERMCAP"))))

(defun self/reload-theme ()
  "Load theme as per the environment"
  (interactive)
  (cond ((and (self/-inside-screenp)
              (self/-dark-modep))
         (message "Skipping loading dark theme inside screen"))
        ((self/-dark-modep) (self/load-dark-theme))
        ;; preferring less bright theme for sometime
        (t (self/load-less-bright-theme)))
        ;; (t (self/load-light-theme))
)

(self/reload-theme)

;; (require 'color-identifiers-mode)
;; (let ((faces '(font-lock-comment-face
;;                font-lock-comment-delimiter-face
;;                font-lock-constant-face
;;                font-lock-type-face
;;                font-lock-function-name-face
;;                font-lock-variable-name-face
;;                font-lock-keyword-face
;;                font-lock-string-face
;;                font-lock-builtin-face
;;                font-lock-preprocessor-face
;;                font-lock-warning-face
;;                font-lock-doc-face)))
;;   (dolist (face faces)
;;     (set-face-attribute face nil :foreground nil :weight 'normal :slant 'normal)))
