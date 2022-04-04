;;; tamil-phonetic.el --- Tamil Phonetic Input for Emacs -*- coding: utf-8-emacs; lexical-binding: t; -*-

;; Copyright (C) 2021 Ramesh Nedunchezian <rameshnedunchezian at outlook dot com>

;; Author: Ramesh Nedunchezian <rameshnedunchezian at outlook dot com>
;; Maintainer: Ramesh Nedunchezian <rameshnedunchezian at outlook dot com>
;; Keywords: multilingual, Indian, Tamil
;; Homepage: https://github.com/rnchzn/tamil-phonetic

;; Package-Requires:

;; This file is NOT part of GNU Emacs.

;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of the
;; License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Phonetic Input Method for Tamil
;; ================================
;;
;; This library provides Phonetic Input Method for Tamil.  The default
;; key mappings are same as that provided by 'Tamil Phonetic Input
;; Method' bundled with Debian's "Multilingual text processing library
;; - database" (`m17n-db'), specifically version `1.8.0-3.'  See
;; following links for more details:
;;
;; - https://savannah.nongnu.org/projects/m17n :: The m17n library is
;;   to support various aspects (e.g. input methods, layout engines)
;;   of multi-lingual text processing.
;;
;; - https://git.savannah.nongnu.org/cgit/m17n/m17n-db.git/plain/MIM/ta-phonetic.mim?h=REL-1-8-0
;;   :: ta-phonetic.mim (v1.8.0)
;;
;; - https://packages.debian.org/m17n-db :: Multilingual text
;;   processing library - database

;; Implementations details
;; =======================
;;
;; Implementation parallels Emacs' in-built `tamil-itrans' input
;; method.

;; Differences between `ta-phonetic.mim' and this library
;; ======================================================
;;
;; - `ta-phonetic.mim' has NO entries for `ௐ'.  This library maps it
;;   to keys `AUM` and `OM`, the same sequences of keys used by
;;   `tamil-itrans'.
;;
;; - `ta-phonetic.mim' has NO entries for Tamil decimal digits.  This
;;   library (optionally) maps them to latin decimal digits.
;;
;; - `ta-phonetic.mim' maps character ஸ்ரீ to keys `sri'.  That
;;   character is apparently composed with individual characters `ஸ்'
;;   and `ரீ'.  So, this library provides no additional entries for
;;   this character.  So, to input `ஸ்ரீ' with this library use `Srii'.

;; Additional Comments
;; ===================
;;
;; The default mappings installed by `ta-phonetic.mim' (and hence this
;; library) are in some instances unintuitive, confusing or contrary
;; to what a native speaker would come to expect.  Despite this
;; limitation, this library uses the same input keys as
;; `ta-phonetic.mim'.  This choice is deliberate.  This allows you to
;; easily switch between typing in Emacs' (using this library), and
;; typing in Tamil in other apps like LibreOffice (using `m17n-db').

;; User Customization
;; ==================
;;
;; If you disagree with the default mappings installed by this
;; library, you can set up your own mappings by customizing
;; `tamil-phonetic-vowels' and `tamil-phonetic-consonants'.
;;
;; If you would like to input Tamil Decimal Numerals, turn on the
;; option `tamil-phonetic-use-tamil-decimal-digits' .

;; User Commands for Transliteration
;; =================================
;;
;; Much like `tamil-itrans', you can use this library to transliterate
;; between English and Tamil using the following commands:
;;
;; - M-x `tamil-phonetic-transiterate-english->tamil' :: Convert
;;   English letters in marked region to Tamil.
;;
;; - M-x `tamil-phonetic-transiterate-tamil->english' :: Convert Tamil
;;   letters in marked region to English.
;;

;; Emacs Bugs/RFEs
;; ===============
;;
;; This library duplicates some code from Emacs' itrans libraries.
;; This duplication can be avoided once the issues mentioned in
;; https://debbugs.gnu.org/cgi/bugreport.cgi?bug=50143 are addressed.
;;

;; TODOs
;; =====
;;
;; Search for "TODO"s in this file.
;;

;;; Code:

(require 'quail)
(require 'ind-util)
(require 'shr)
(require 'dash)
(require 's)

(defvar tamil-phonetic-vowel-letters
  '("அ" "ஆ" "இ" "ஈ" "உ" "ஊ" "எ" "ஏ" "ஐ" "ஒ" "ஓ" "ஔ"))

(defvar tamil-phonetic-num-vowel-letters
  (length tamil-phonetic-vowel-letters))

(defvar tamil-phonetic-consonant-letters
  '("க்" "ங்" "ச்" "ஞ்" "ட்" "ண்" "த்" "ந்" "ப்" "ம்" "ய்" "ர்" "ல்" "வ்" "ழ்" "ள்" "ற்" "ன்"))

(defvar tamil-phonetic-num-consonant-letters
  (length tamil-phonetic-consonant-letters))

(defvar tamil-phonetic-other-consonant-letters
  '("ஜ்" "ஷ்" "ஸ்" "ஶ்" "ஹ்" "க்‌ஷ்" "க்ஷ்"))

(defgroup tamil-phonetic nil
  "Tamil Phonetic Input Method."
  :tag "Tamil Phonetic Input Method"
  :group 'languages)

;; TODO
;;
;; Add a `:set' function for all `defcustom's.

(defun tamil-phonetic--set-custom-var (var val)
  (set var val)
  (when (featurep 'tamil-phonetic)
    (message "Please restart Emacs for changes to take effect")
    (sleep-for 1)))

(defcustom tamil-phonetic-vowels
  '(("அ" "a")
    ("ஆ" "A" "aa")
    ("இ" "i")
    ("ஈ" "I" "ii")
    ("உ" "u")
    ("ஊ" "U" "uu")
    ("எ" "e")
    ("ஏ" "E" "ee")
    ("ஐ" "ai")
    ("ஒ" "o")
    ("ஓ" "O" "oo")
    ("ஔ" "au")
    ("ஃ" "q"))
  "Map Tamil vowels to Input keys.

You need to restart Emacs for changes to take effect.

These mappings are also used when transiterating between Tamil
and English.  See commands
`tamil-phonetic-transiterate-tamil->english' and
`tamil-phonetic-transiterate-english->tamil'."
  :group 'tamil-phonetic
  :type '(alist :tag "Input keys for Tamil vowels"
		:key-type (string :tag "Tamil letter")
		:value-type (repeat :tag "Input keys"
				    (string :tag "Input keys")))
  :set #'tamil-phonetic--set-custom-var)

(defvar tamil-phonetic-vowel-signs
  '(("அ" . "")
    ("ஆ" . "ா")
    ("இ" . "ி")
    ("ஈ" . "ீ")
    ("உ" . "ு")
    ("ஊ" . "ூ")
    ("எ" . "ெ")
    ("ஏ" . "ே")
    ("ஐ" . "ை")
    ("ஒ" . "ொ")
    ("ஓ" . "ோ")
    ("ஔ" . "ௌ")))

(defcustom tamil-phonetic-consonants
  '(("க்" "k")
    ("ங்" "ng")
    ("ச்" "c" "s")
    ("ஞ்" "nj")
    ("ட்" "t" "d")
    ("ண்" "N")
    ("த்" "th")
    ("ந்" "w" "n-")
    ("ப்" "p")
    ("ம்" "m")
    ("ய்" "y")
    ("ர்" "r")
    ("ல்" "l")
    ("வ்" "v")
    ("ழ்" "z")
    ("ள்" "L")
    ("ற்" "R")
    ("ன்" "n")
    ("ஜ்" "j")
    ("ஷ்" "sh")
    ("ஸ்" "S")
    ("ஶ்" "Z")
    ("ஹ்" "h")
    ("க்‌ஷ்" "ksh")
    ("க்ஷ்" "ksH")
    ;; ("ஶ்ரீ" "sri") Use Srii
    )
  "Map Tamil consonants to Input keys.

You need to restart Emacs for changes to take effect.

These mappings are also used when transiterating between Tamil
and English.  See commands
`tamil-phonetic-transiterate-tamil->english' and
`tamil-phonetic-transiterate-english->tamil'."
  :group 'tamil-phonetic
  :type '(alist :tag "Input keys for Tamil consonants"
		:key-type (string :tag "Tamil letter")
		:value-type (repeat :tag "Input keys"
				    (string :tag "Input keys")))
  :set #'tamil-phonetic--set-custom-var)

(defcustom tamil-phonetic-use-tamil-decimal-digits nil
  "Map Latin Decimal Digits to Tamil Decimal Digits, when non-nil.

You need to restart Emacs for changes to take effect."
  :group 'tamil-phonetic
  :type '(choice (const :tag "Use Tamil Decimal Digits" t)
		 (const :tag "Use Latin Decimal Digits" nil))
  :set #'tamil-phonetic--set-custom-var)

;; `indian-tml-base-table'

;; `indian-itrans-v5-table-for-tamil'

;; Workaround for some of the issues mentioned in
;; https://debbugs.gnu.org/cgi/bugreport.cgi?bug=50143

(setcar (nthcdr (seq-position (nth 2 indian-itrans-v5-table-for-tamil) '("AUM" "OM")
			      (lambda (s1 s2)
				(when (and (consp s1) (consp s2))
				  (string= (car s1) (car s2)))))
		(nth 2 indian-tml-base-table))
	?ௐ)

(setcar (nthcdr (seq-position (nth 1 indian-itrans-v5-table-for-tamil) "sh"
			      (lambda (s1 s2)
				(when (and (stringp s1) (stringp s2))
				  (string= s1 s2))))
		(nth 1 indian-tml-base-table))
	?ஶ)

(defvar tamil-phonetic-table-indian
  `(;; for encode/decode
    ,(->> (car indian-tml-base-table)
       (--map (when it (char-to-string (car it))))
       (--map (assoc-default it tamil-phonetic-vowels))
       (--map (if (cdr it) it (car it))))
    ,(->> (nth 1 indian-tml-base-table)
       (--map (when it (if (numberp it)
			   (with-temp-buffer (insert it 3021) (buffer-string)) it)))
       (--map (assoc-default it tamil-phonetic-consonants))
       (--map (if (cdr it) it (car it))))
    (;; misc -- 7
     ;; ".N" (".n" "M") "H" ".a" ".h" ("AUM" "OM") ".."
     nil nil ,(car (assoc-default "ஃ" tamil-phonetic-vowels)) nil nil ("AUM" "OM") nil)))

(defun tamil-phonetic--indian-make-hash (table trans-table &optional need-native-digits)
  "Indian Transliteration Hash for decode/encode.

Same as `indian-make-hash' with added NEED-NATIVE-DIGITS.  See
https://debbugs.gnu.org/cgi/bugreport.cgi?bug=50143."
  (let* ((encode-hash (make-hash-table :test 'equal))
	 (decode-hash (make-hash-table :test 'equal))
	 (hashtbls (cons encode-hash decode-hash))
	 (vowels (elt table 0))
	 (consonants (elt table 1))
	 (misc (elt table 2))
	 (digits (elt table 3))
	 (halant (char-to-string (elt misc 4)))
	 (trans-vowels (elt trans-table 0))
	 (trans-consonants (elt trans-table 1))
	 (trans-misc (elt trans-table 2))
	 (trans-digits '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9")))
    (indian--puthash-v vowels trans-vowels hashtbls)
    (indian--puthash-c consonants trans-consonants halant hashtbls)
    (indian--puthash-cv consonants trans-consonants
			vowels trans-vowels hashtbls)
    (indian--puthash-m misc trans-misc hashtbls)
    (when need-native-digits
      (indian--puthash-m digits trans-digits hashtbls))
    hashtbls))

(defvar tamil-phonetic-hashtable
  ;; (indian-make-hash indian-tml-base-table
  ;;		    tamil-phonetic-table-indian)

  (tamil-phonetic--indian-make-hash indian-tml-base-table
				    tamil-phonetic-table-indian
				    tamil-phonetic-use-tamil-decimal-digits))

;;; Utilities to build the docstring for `describe-input-method'

(defvar tamil-phonetic-pad-left " ")
(defvar tamil-phonetic-pad-right " ")

(defun tamil-phonetic--regularize-table (table)
  (-> (->> table
	(-map #'length)
	(-max)
	(-iota))
    (-select-columns table)))

(defun tamil-phonetic--transpose-table (table)
  (->> table
    (car)
    (length)
    (-iota)
    (-map (lambda (i)
	    (--map (nth i it) table)))))

(defun tamil-phonetic--table-col-widths (table)
  (->> table
    (-tree-map (lambda (cell)
		 (concat tamil-phonetic-pad-left cell tamil-phonetic-pad-right)))
    (-tree-map (lambda (cell)
		 (let ((shr-use-fonts t))
		   (shr-string-pixel-width cell))))
    (tamil-phonetic--transpose-table)
    (--map (-max it))))

(defun tamil-phonetic--table-print (table &optional caption)
  (let* ((table (->> table
		  ;; (-tree-map (lambda (s)
		  ;; 	       (let ((script (when (stringp s)
		  ;; 			       (aref char-script-table (string-to-char s)))))
		  ;; 		 (pcase script
		  ;; 		   ('tamil (propertize s 'font-lock-face 'outline-1))
		  ;; 		   ('latin (propertize s 'font-lock-face 'outline-2))
		  ;; 		   (_ s)))))
		  ))
	 (col-widths (->> table
		       (-non-nil)
		       (tamil-phonetic--table-col-widths)))
	 (cum-widths (->> col-widths
		       (-running-sum)))
	 (table-pixel-width (car (last cum-widths)))
	 (table-width (1+ (/ table-pixel-width (shr-string-pixel-width "-"))))
	 (hline (make-string table-width ?-)))
    (when caption
      (insert "\n" hline)
      (insert "\n" (->> caption
		     ((lambda (s)
			(let* ((len table-width)
			       (extra (max 0 (- len (length s)))))
			  (concat (make-string (ceiling extra 2) ? )
				  s (make-string (floor extra 2) ? )))))))
      (insert "\n" hline))
    (cl-loop for row in table do
	     (if (not row)
		 (insert "\n" hline)
	       (insert "\n")
	       (cl-loop for cell in row
			for cum-width in cum-widths do
			(insert (concat tamil-phonetic-pad-left cell
					(propertize tamil-phonetic-pad-right
						    'display (list 'space :align-to (list cum-width))))))))
    (when caption
      (insert "\n" hline))))

(defun tamil-phonetic--table-print-as-string (table &optional caption)
  (with-temp-buffer
    (tamil-phonetic--table-print table caption)
    (buffer-string)))

;;; Build the main help table

(defun tamil-phonetic-syllable-table-as-string ()
  (with-temp-buffer
    (let* ((cs (->> tamil-phonetic-consonants (cons (list 'unit 'unit))))
	   (vs (->> tamil-phonetic-vowels
		 (-take 12)
		 (cons (list 'unit 'unit))
		 (tamil-phonetic--regularize-table)
		 (--map (-replace nil 'nokey it))
		 (tamil-phonetic--transpose-table)))
	   (table
	    (append
	     (list
	      (->> vs
		(-tree-map (lambda (v)
			     (let* ((result (if (eq v 'unit) "" v)))
			       (if (eq result 'nokey) ""
				 result))))))
	     (-zip-pair
	      (-table
	       (lambda (v c)
		 (cond
		  ((eq c 'unit) "")
		  ((eq v 'unit) c)
		  (t (with-temp-buffer
		       (insert (with-temp-buffer
				 (apply #'insert (butlast (seq-into c 'list)))
				 (buffer-string))
			       (assoc-default v tamil-phonetic-vowel-signs))
		       (buffer-string)))))
	       (car vs) (->> cs (-map #'car) (cdr)))
	      (->> cs (-map #'cdr)
		   (cdr)
		   (-map (lambda (cs)
			   (-mapcat
			    (lambda (c)
			      (when c
				(->> (cdr vs)
				  (-tree-map (lambda (v)
					       (cond
						((eq v 'unit) c)
						((eq v 'nokey) "")
						(t (with-temp-buffer
						     (insert c v)
						     (buffer-string)))))))))
			    cs))))))))
      (->> table
	(-interpose '(nil))
	(-flatten-n 1)
	(--map (when it (-insert-at 1 "|" it)))
	(tamil-phonetic--table-print)))
    (buffer-string)))

;; (insert (tamil-phonetic-syllable-table-as-string))

(defun tamil-phonetic-vowels-table-as-string ()
  (-> (->> tamil-phonetic-vowels
	(tamil-phonetic--regularize-table)
	(--map (-replace nil "" it))
	(tamil-phonetic--transpose-table))
    (tamil-phonetic--table-print-as-string "vowels")))

;; (insert (tamil-phonetic-vowels-table-as-string))

(defun tamil-phonetic-consonants-table-as-string ()
  (-> (->> tamil-phonetic-consonants
	(-take tamil-phonetic-num-consonant-letters)
	(tamil-phonetic--regularize-table)
	(--map (-replace nil "" it))
	(tamil-phonetic--transpose-table))
    (tamil-phonetic--table-print-as-string "consonants")))

;; (insert (tamil-phonetic-consonants-table-as-string))

(defun tamil-phonetic-other-consonants-table-as-string ()
  (-> (->> tamil-phonetic-consonants
	(-drop tamil-phonetic-num-consonant-letters)
	(tamil-phonetic--regularize-table)
	(--map (-replace nil "" it))
	(tamil-phonetic--transpose-table))
    (tamil-phonetic--table-print-as-string "other consonants")))

;; (insert (tamil-phonetic-other-consonants-table-as-string))

(defvar tamil-phonetic-digits
  (let ((digits '("௦" "௧" "௨" "௩" "௪" "௫" "௬" "௭" "௮" "௯")))
    (->> digits
      (-map-indexed (lambda (i it) (list it (number-to-string i)))))))

(defun tamil-phonetic-digits-table-as-string ()
  (-> tamil-phonetic-digits
    (tamil-phonetic--transpose-table)
    (tamil-phonetic--table-print-as-string "digits")))

;; (insert (tamil-phonetic-digits-table-as-string))

(defvar tamil-phonetic-various
  '(("ஃ" "H")
    ("ஸ்ரீ" "srii")
    ("ௐ" "")))

(defun tamil-phonetic-various-table-as-string ()
  (-> tamil-phonetic-various
    (tamil-phonetic--transpose-table)
    (tamil-phonetic--table-print-as-string
     "various")))

;; (insert (tamil-phonetic-various-table-as-string))

(defvar tamil-phonetic-numerics
  '(("௰" "பத்து")
    ("௱" "நூறு")
    ("௲" "ஆயிரம்")))

(defun tamil-phonetic-numerics-table-as-string ()
  (-> tamil-phonetic-numerics
    (tamil-phonetic--transpose-table)
    (tamil-phonetic--table-print-as-string "numerics")))

;; (insert (tamil-phonetic-numerics-table-as-string))

(defvar tamil-phonetic-symbols
  '(("௳" "நாள்")
    ("௴" "மாதம்")
    ("௵" "வருடம்")
    ("௶" "பற்று")
    ("௷" "வரவு")
    ("௸" "மேற்படி")
    ("௹" "ரூபாய்")
    ("௺" "எண்")))

(defun tamil-phonetic-symbols-table-as-string ()
  (-> tamil-phonetic-symbols
    (tamil-phonetic--transpose-table)
    (tamil-phonetic--table-print-as-string "symbols")))

;; (insert (tamil-phonetic-symbols-table-as-string))

(quail-define-package "tamil-phonetic" "Tamil" "TmlPho" t
		      (concat
		       "Tamil transliteration by Phonetic method.

You can input characters using the following mapping tables.
    Example: To enter வணக்கம், type vaNakkam."

		       "\n\n### Vowels ###\n\n"

		       (tamil-phonetic-vowels-table-as-string)

		       "\n\n### Consonants ###\n\n"

		       (tamil-phonetic-consonants-table-as-string)

		       "\n\n### Other Consonants ###\n\n"

		       (tamil-phonetic-other-consonants-table-as-string)

		       "\n\n### Basic syllables (consonants + vowels) ###\n\n"

		       (tamil-phonetic-syllable-table-as-string)

		       "\n\n### Digits ###\n\n"

		       (tamil-phonetic-digits-table-as-string)

		       "\n\n### Various signs ###\n\n"

		       (tamil-phonetic-various-table-as-string)

		       "\n\n### Numerics ###

Characters below have no PHONETIC method associated with them.
Their descriptions are included for easy reference.\n\n"

		       (tamil-phonetic-numerics-table-as-string)

		       "\n\n### Symbos ###

Characters below have no PHONETIC method associated with them.
Their descriptions are included for easy reference.\n\n"

		       (tamil-phonetic-symbols-table-as-string)

		       "\n\nFull key sequences are listed below:\n\n")

		      nil nil nil nil nil nil t nil)

(maphash
 (lambda (key val)
   (quail-defrule key (if (= (length val) 1)
			  (string-to-char val)
			(vector val))))
 (cdr tamil-phonetic-hashtable))

;; TODO
;; ====
;;
;; The macro `indian-translate-rgion' evals `tamil-phonetic-hashtable'
;; during compile time.  So, byte compilation of this file will fail.
;; As a workaround, just load the uncompiled file.  Consider adding an
;; `eval-and-compile' or other equivalent workarounds.
;;
;; (indian-translate-region
;;  from to tamil-phonetic-hashtable t)

(defun tamil-phonetic--transiterate-region (from to hashtable encode-p)
  ;; Same as `indian-translate-region'.
  (save-excursion
    (save-restriction
      (let ((regexp (indian-regexp-of-hashtbl-keys
		     (if encode-p (car hashtable)
		       (cdr hashtable)))))
	(narrow-to-region from to)
	(goto-char (point-min))
	(while (re-search-forward regexp nil t)
	  (let ((matchstr (gethash (match-string 0)
				   (if encode-p
				       (car hashtable)
				     (cdr hashtable)))))
	    (if matchstr (replace-match matchstr))))))))

(defun tamil-phonetic-transiterate-tamil->english (from to)
  "Convert English letters in region to Tamil.

Use Tamil Phonetic mapping for conversion.  See variables
`tamil-phonetic-vowels' and `tamil-phonetic-consonants'."
  (interactive "r")
  ;; (indian-translate-region
  ;;  from to tamil-phonetic-hashtable t)
  (tamil-phonetic--transiterate-region
   from to tamil-phonetic-hashtable t))

(defun tamil-phonetic-transiterate-english->tamil (from to)
  "Convert English letters in region to Tamil.

Use Tamil Phonetic mapping for conversion.  See variables
`tamil-phonetic-vowels' and `tamil-phonetic-consonants'."
  (interactive "r")
  (tamil-phonetic--transiterate-region
   from to tamil-phonetic-hashtable nil))

(provide 'tamil-phonetic)

;; Local Variables:
;; eval: (goto-address-mode 1)
;; End:
