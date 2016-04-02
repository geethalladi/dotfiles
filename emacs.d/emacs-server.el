;; Start emacs server
(require 'server)
(unless (server-running-p)
  (server-start))
