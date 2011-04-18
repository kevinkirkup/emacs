[ ] (defvar angrytuna-todo-global-file "~/.todo"
  "Path to the todo file used by `angrytuna-todo-quick-jump' and friends.")

(defun angrytuna-todo-quick-enter ()
  "Prompts for a new todo item to be inserted into the global todo file."
  (interactive)
  (let ((item (read-string "TODO: ")))
    (if (string= "" item)
        (angrytuna-todo-quick-jump)
      (angrytuna-todo-add-global-item item))))

(defun angrytuna-todo-quick-jump ()
  "Visits the global todo file."
  (interactive)
  (find-file angrytuna-todo-global-file))

(defun angrytuna-todo-add-global-item (item)
  "Adds an item to the global todo file."
  (save-excursion
    (set-buffer (find-file-noselect angrytuna-todo-global-file))
    (when (not (= (point-min) (point-max)))
      (goto-char (point-max))
      (insert "\n"))
    (insert item)
    (angrytuna-todo-toggle))
  (message "TODO: Item added."))

(defun angrytuna-todo-toggle ()
  "Toggles the todo state if it's active, otherwise activates it. "
  (interactive)
  (save-excursion
    (move-beginning-of-line 1)
    (if (string= (char-to-string (char-after)) "[")
        (angrytuna-todo-toggle-status)
      (insert "[ ] "))
    (save-buffer)))

(defun angrytuna-todo-done? ()
  "Is this line a done todo item?"
  (save-excursion
    (move-beginning-of-line 1)
    (search-forward "[ ]" (+ 3 (point)) t)))

(defun angrytuna-todo-toggle-status ()
  "Toggle the todo state."
  (interactive)
  (save-excursion
    (if (angrytuna-todo-done?)
        (angrytuna-todo-set-done)
      (angrytuna-todo-set-begun))))

(defun angrytuna-todo-set-begun ()
  "Set a todo item as begun."
  (angrytuna-todo-set-status " "))

(defun angrytuna-todo-set-done ()
  "Set a todo item as done."
  (angrytuna-todo-set-status "X"))

(defun angrytuna-todo-set-status (status)
  "Give the current todo item to an arbitrary status."
  (save-excursion
    (move-beginning-of-line 1)
    (forward-char 1)
    (delete-char 1)
    (insert status)))

(defun angrytuna-todo-move-item-up ()
  "Moves the focused todo item down a line."
  (interactive)
  (save-excursion
    (beginning-of-line 1)
    (when (not (= (point-min) (point)))
      (let ((word (delete-and-extract-region (point) (point-at-eol))))
        (delete-char 1)
        (forward-line -1)
        (insert (concat word "\n")))
      (save-buffer)))
  (when (not (= (point-min) (point)))
    (forward-line -2)))

(defun angrytuna-todo-move-item-down ()
  "Moves the focused todo item up a line."
  (interactive)
  (let (eof chars)
    (setq chars (- (point) (point-at-bol)))
    (save-excursion
      (end-of-line 1)
      (setq eof (= (point-max) (point)))
      (when (not eof)
        (let ((word (delete-and-extract-region (point-at-bol) (point))))
          (delete-char 1)
          (forward-line 1)
          (insert (concat word "\n")))
        (save-buffer)))
    (when (not eof)
      (forward-line 1)

)))