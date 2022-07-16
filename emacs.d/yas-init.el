;; Making yasnippet and company mode interop <tab>
;; Reference : https://emacs.stackexchange.com/questions/7908/how-to-make-yasnippet-and-company-work-nicer

(require 'yasnippet)
(require 'yasnippet-snippets)

;; adding yassnippets for yard mode
(let ((yard-snippet-dir
       (expand-file-name "site-lisp/yard-snippets" user-emacs-directory)))
  (if (file-directory-p yard-snippet-dir)
      (add-to-list 'yas-snippet-dirs yard-snippet-dir)))

(yas-global-mode 1)
