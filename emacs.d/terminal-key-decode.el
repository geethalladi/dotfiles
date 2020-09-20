(defun self/-custom-decode-map ()
  "Customize decode input sequences"
  ;; ctrl keys
  (define-key input-decode-map "\e[1;5E" [C-return])

  ;; alt keys

  ;; cmd keys
  ;; TODO: [1;7 is a hack. Find out what is the proper control sequence for cmd
  (define-key input-decode-map "\e[1;7S" (kdb "s-/"))

  ;; shift keys
  (define-key input-decode-map "\e[1;2A" [S-up])
  (define-key input-decode-map "\e[1;2B" [S-down])
  (define-key input-decode-map "\e[1;2C" [S-right])
  (define-key input-decode-map "\e[1;2D" [S-left]))

(if (getenv "TERM_PROGRAM")
    ;; decode the escape sequences inside the terminal
    (self/-custom-decode-map))
