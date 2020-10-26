;; ligatures using composition char table ;;

;; The basic idea is to provide starting character, and a regular expression, that matches all
;; ligatures starting with that character, and put it to the composition table.

;; reference: https://andreyorst.gitlab.io/posts/2020-07-21-programming-ligatures-in-emacs/

(when (window-system)
  ;; enabling ligatures only in native UI
  ;; terminal takes care of the ligature support itself
  (use-package composite
    :hook (prog-mode . auto-composition-mode)
    :init (global-auto-composition-mode -1))

  (let ((ligatures `((?-  . ,(regexp-opt '("-|" "-~" "---" "-<<" "-<" "--" "->" "->>" "-->")))
                     (?/  . ,(regexp-opt '("/**" "/*" "///" "/=" "/==" "/>" "//")))
                     (?*  . ,(regexp-opt '("*>" "***" "*/")))
                     (?<  . ,(regexp-opt '("<-" "<<-" "<=>" "<=" "<|" "<||" "<|||::=" "<|>" "<:" "<>" "<-<"
                                           "<<<" "<==" "<<=" "<=<" "<==>" "<-|" "<<" "<~>" "<=|" "<~~" "<~"
                                           "<$>" "<$" "<+>" "<+" "</>" "</" "<*" "<*>" "<->" "<!--")))
                     (?:  . ,(regexp-opt '(":>" ":<" ":::" "::" ":?" ":?>" ":=")))
                     (?=  . ,(regexp-opt '("=>>" "==>" "=/=" "=!=" "=>" "===" "=:=" "==")))
                     (?!  . ,(regexp-opt '("!==" "!!" "!=")))
                     (?>  . ,(regexp-opt '(">]" ">:" ">>-" ">>=" ">=>" ">>>" ">-" ">=")))
                     (?&  . ,(regexp-opt '("&&&" "&&")))
                     (?|  . ,(regexp-opt '("|||>" "||>" "|>" "|]" "|}" "|=>" "|->" "|=" "||-" "|-" "||=" "||")))
                     (?.  . ,(regexp-opt '(".." ".?" ".=" ".-" "..<" "...")))
                     (?+  . ,(regexp-opt '("+++" "+>" "++")))
                     (?\[ . ,(regexp-opt '("[||]" "[<" "[|")))
                     (?\{ . ,(regexp-opt '("{|")))
                     (?\? . ,(regexp-opt '("??" "?." "?=" "?:")))
                     (?#  . ,(regexp-opt '("####" "###" "#[" "#{" "#=" "#!" "#:" "#_(" "#_" "#?" "#(" "##")))
                     (?\; . ,(regexp-opt '(";;")))
                     (?_  . ,(regexp-opt '("_|_" "__")))
                     (?\\ . ,(regexp-opt '("\\" "\\/")))
                     (?~  . ,(regexp-opt '("~~" "~~>" "~>" "~=" "~-" "~@")))
                     (?$  . ,(regexp-opt '("$>")))
                     (?^  . ,(regexp-opt '("^=")))
                     (?\] . ,(regexp-opt '("]#"))))))
    (dolist (char-regexp ligatures)
      (set-char-table-range composition-function-table (car char-regexp)
                            `([,(cdr char-regexp) 0 font-shape-gstring])))))
