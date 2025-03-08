;;; sk-daily.el --- daily journaling module

;;; Commentary:
;;
;; Something like Obsidian daily notes file.
;; influenced by: https://gist.github.com/amitp/7a133026dafac2131e5f023d43acbc16

;;; Code:

(defvar sk-daily-directory "~/org/daily/")
(defvar sk-daily-filename (expand-file-name (concat sk-daily-directory "%Y-%m-%d.org")))

(defun sk-daily-extract-date-from-filename (filename)
  "Extracts YYYY-MM-DD date from FILENAME if it matches the pattern '~/a/b/YYYY-MM-DD.org'."
  (if (string-match "/\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\)\\.org$" filename)
      (match-string 1 filename)
    nil))  ;; Return nil if no match

(defun sk-daily-get-string-from-file (filePath)
  "Return file content as string."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(defun sk-daily-convert-date-string-to-time (date-string)
  "Convert DATE-STRING (YYYY-MM-DD) into a time value suitable for `format-time-string`.
Returns nil if DATE-STRING is not valid."
  (when date-string
    (let* ((parsed-time (parse-time-string date-string)))
      (encode-time 0 0 0
                   (nth 3 parsed-time)  ;; Day
                   (nth 4 parsed-time)  ;; Month
                   (nth 5 parsed-time)  ;; Year
                   nil nil nil))))      ;; Other values (DST, etc.)


(defun sk-daily-today ()
  "Open today's file"
  (interactive)
  (find-file (format-time-string sk-daily-filename))
  (when (equal (point-max) 1)
    (let ((calendar-date (sk-daily-extract-date-from-filename (buffer-file-name))))
      (insert (format-time-string
               (sk-daily-get-string-from-file
                (concat sk-daily-directory "/daily-template.org"))
               (sk-daily-convert-date-string-to-time calendar-date)))))
  (goto-char (point-max)))

(defun sk-daily-today-file ()
  "Return today's daily file path and ensure it has a template if it does not exist."
  (let ((file (expand-file-name (format-time-string sk-daily-filename))))
    (unless (file-exists-p file)
      (with-temp-buffer
        (let ((calendar-date (sk-daily-extract-date-from-filename file)))
          (insert (format-time-string
                   (sk-daily-get-string-from-file
                    (concat sk-daily-directory "/daily-template.org"))
                   (sk-daily-convert-date-string-to-time calendar-date))))
        (write-file file)))
    file))  ;; Return the file path


(provide 'sk-daily)
;;; sk-daily.el ends here
