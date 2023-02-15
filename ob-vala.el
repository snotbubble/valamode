;; bare minimum vala ob file
;; by c.p.brown 2023
;; do with as you please
;;
;; handles string and number (int & float) variables
;;
;; get this working by saving it to ~./emacs.d
;; then add the following indicated lines to ~./.emacs
;;
;; ->    (load-file "~/.emacs.d/ob-vala.el")
;;       (org-babel-do-load-languages 'org-babel-load-languages '(
;; ->        (vala . t)
;;       ))
;;
;; remove by hosing the indicated lines and deleting the file
;;
;; injects vars (aka params here) into the main block:
;;    ...main(string[] args) {
;;        varname = """string goes here...""";
;;        anothervar = 1.0;
;;
;; tested OK with 4000 lines of csv in incoming vars,
;; its as slow as python to do the same thing (probably more checking in vala).
;; the binary itself is about 3x faster when run in the terminal, so the delay is mostly the compiler.
;;
;; TODO:
;; - check to see if a binary exists and just run it if `compile=false` is set on the block, ignore and compile anyway if the binary doesn't exist. There should also be some way to let me know the binary is out of date if I alter the code.


(require 'ob)

(defun org-babel-execute:vala (body params)
	"execute vala code"
	(setq blkname (format "%s" (nth 4 (org-babel-get-src-block-info))))
	(setq tmpfile (org-babel-temp-file (format "%svalatemp_" (file-name-directory buffer-file-name)) ".vala"))
	(setq par (mapconcat 'identity (org-babel-variable-assignments:vala params) "\n"))
	(with-temp-file tmpfile 
		(insert 
			(replace-regexp-in-string "main[\s(]+string[\s\[\]]+ args[\s)]+[\s{]+\n" 
				(concat "main (string[] args) {\n\n" par "\n")
				(org-babel-expand-body:generic body params)
			)
		)
	)
    (org-babel-eval 
		(format "valac %s -o valatemp && rm %s && ./valatemp" (org-babel-process-file-name tmpfile) (org-babel-process-file-name tmpfile)) 
		""
	)
)

(defun org-babel-variable-assignments:vala (params)
	"Return a list of vala statements assigning the block's variables."
	(mapcar
		(lambda (pair)
			(cond
				((numberp (cdr pair)) (format "\nstring %s = %s;\n" (car pair) (cdr pair)))
				((stringp (cdr pair)) (format "\nstring %s = \"\"\"%s\"\"\";\n" (car pair) (cdr pair)))
				(t "")
			)
		)
 		(org-babel--get-vars params)
	)
)

(provide 'ob-vala)
