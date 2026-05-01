(defun self/load-tamil-lang ()
  (require 'tamil-phonetic)
  (set-fontset-font "fontset-default" 'tamil
                    (font-spec :family "Tiro Tamil" :size 16))
  (custom-set-variables
   '(default-input-method "tamil-phonetic"))

  (custom-set-variables
   '(tamil-phonetic-consonants
     '(("க்" "k" "g")
       ("ங்" "ng")
       ("ச்" "c" "s" "ch")
       ("ஞ்" "nj" "gn")
       ("ட்" "t" "d")
       ("ண்" "n")
       ("த்" "th" "dh")
       ("ந்" "nh" "nd" "nnn")
       ("ப்" "p" "b")
       ("ம்" "m")
       ("ய்" "y")
       ("ர்" "r")
       ("ல்" "l")
       ("வ்" "v")
       ("ழ்" "z" "zh")
       ("ள்" "L" "ll")
       ("ற்" "tr" "R" "rr")
       ("ன்" "N" "nn")
       ("ஜ்" "j")
       ("ஷ்" "sh")
       ("ஸ்" "S")
       ("ஶ்" "Z")
       ("ஹ்" "h")
       ("க்‌ஷ்" "ksh")
       ("க்ஷ்" "ksH")))))

(defun self/load-sanskrit-lang ()
  (set-fontset-font "fontset-default" 'devanagari
                    (font-spec :family "Tiro Devanagari Sanskrit" :size 18))
  ;; sanskrit minor mode
  (straight-use-package
   '(sanskrit :type git
              :repo "https://github.com/sctb/sanskrit"
              :local-repo "sanskrit")))

(self/load-tamil-lang)
(self/load-sanskrit-lang)
