
(defvar insert-time-format "%X"
  "*Format for \\[insert-time] (.c.f format-time-string').")

(defvar insert-date-format "%x"
  "*Format for \\[insert-date] (.c.f format-time-string').")

(defun insert-time ()
  "Insert the current time according to insert-time-format."
  (interactive "*")
  (insert (format-time-string insert-time-format
                              (current-time))))

(defun insert-date ()
  "Insert the current time according to insert-time-format."
  (interactive "*")
  (insert (format-time-string insert-date-format
                              (current-time))))

(provide 'timestamp)
