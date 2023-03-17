;; bare minimum vala ob file
;; by c.p.brown 2023
;; do not use this script, its for my own personal use only

(require 'ob)

(defun org-babel-execute:vala (body params)
	"execute vala code"
	(setq blkname (format "%s" (nth 4 (org-babel-get-src-block-info))))
	(setq tmpfile (org-babel-temp-file (format "%svalatemp_" (file-name-directory buffer-file-name)) ".vala"))
	(setq par (mapconcat 'identity (org-babel-variable-assignments:vala params) "\n"))
	(setq flg (alist-get :flags (org-babel-process-params params)))
	(if (not flg) (setq flg "") ())
	(with-temp-file tmpfile 
		(insert 
			(replace-regexp-in-string "main[\s(]+string[\s\[\]]+ args[\s)]+[\s{]+\n" 
				(concat "main (string[] args) {\n\n" par "\n")
				(org-babel-expand-body:generic body params)
			)
		)
	)
    (org-babel-eval 
		(format "valac %s -o valatemp %s && rm %s && ./valatemp" (org-babel-process-file-name tmpfile) flg (org-babel-process-file-name tmpfile)) 
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
