;; Adding purescirpt mode to the initial loading list

(require 'purescript-mode)

;; The below does not work for me :-)
;; (require 'purescript-mode-autoloads)

(require 'psc-ide)

(add-hook 'purescript-mode-hook
  (lambda ()
    (psc-ide-mode)
    (company-mode)
    (flycheck-mode)
    (smartparens-mode)
    (turn-on-purescript-indentation)))

(setq psc-ide-use-npm-bin t)
