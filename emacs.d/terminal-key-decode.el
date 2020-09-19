(defun self/-custom-decode-map ()
  "Customize decode input sequences"
  ;; ctrl keys
  (define-key input-decode-map "\e[1;5E" [C-return])

  ;; alt keys

  ;; cmd keys

  ;; shift keys
  (define-key input-decode-map "\e[1;2A" [S-up])
  (define-key input-decode-map "\e[1;2B" [S-down])
  (define-key input-decode-map "\e[1;2C" [S-right])
  (define-key input-decode-map "\e[1;2D" [S-left]))

;; decode the escape sequences inside the terminal
(self/-custom-decode-map)
