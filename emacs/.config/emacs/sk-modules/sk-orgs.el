;;; sk-orgs.el --- misc. org stuff

;;; Commentary:
;;
;; utility stuff for org captures, agendas, ....

;;; Code:

(defvar sk-meets-file "~/org/meets.org")

(defun sk-org-collect-heading2 (org-file)
  "Collect an all headings 2 from an ORG-FILE."
    (set-buffer (org-capture-target-buffer org-file))
      (org-element-map (org-element-parse-buffer) 'headline
	(lambda (el)
	  (when (= 2 (org-element-property :level el))
	    (org-element-property :raw-value el)))
	))

(defun sk-org-find-heading-position (org-file heading)
  "Return position of subtopic heading in org file."
    (set-buffer (org-capture-target-buffer org-file))
      (goto-char (point-min))
      (when (re-search-forward (format org-complex-heading-regexp-format (regexp-quote heading)) nil nil)
        (point)))

(defun sk-org-capture-target (org-file)
  "Interactively select a subtopic from ORG-FILE and return marker for capture target."
  (let* ((heading (completing-read "Choose subtopic: " (sk-org-collect-heading2 org-file)))
         (pos (sk-org-find-heading-position org-file heading)))
    (set-buffer (org-capture-target-buffer org-file))
    (org-end-of-subtree t t)
      ))

(defun sk-meets-capture-target ()
  "Calling sk-org-capture-target with sk-meet-file"
  (sk-org-capture-target sk-meets-file))



(provide 'sk-orgs)
;;; sk-orgs.el ends here
