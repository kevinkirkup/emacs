(defun air ()
  (interactive)
  (replace-string "240" "180")
  (save-buffer))

(defun big ()
  (interactive)
  (replace-string "180" "240")
  (save-buffer))

(defun insert-soft-tab ()
  (interactive)
  (insert "  "))

(defun angrytuna-indent ()
  (interactive)
  (insert "  "))

(defun email ()
  (interactive)
  (markdown-mode)
  (turn-on-word-wrap))

(defun angrytuna-zap-to-char (arg char)
  "Kill up to but excluding ARG'th occurrence of CHAR.
Case is ignored if `case-fold-search' is non-nil in the current buffer.
Goes backward if ARG is negative; error if CHAR not found.
This emulates Vim's `dt` behavior, which rocks."
  (interactive "p\ncZap to char: ")
  (if (char-table-p translation-table-for-input)
      (setq char (or (aref translation-table-for-input char) char)))
  (kill-region (point)
               (progn
                 (search-forward (char-to-string char) nil nil arg)
                 (- (point) 1)))
  (backward-char 1))

(defun word-count ()
  "Count words in buffer"
  (interactive)
  (shell-command-on-region (point-min) (point-max) "wc -w"))

(defun angrytuna-ido-find-config ()
  (interactive)
  (find-file
   (concat "~/.emacs.d/angrytuna/"
           (ido-completing-read "Config file: "
                                (directory-files "~/.emacs.d/angrytuna/"
                                                 nil
                                                 "^[^.]")))))

(defun angrytuna-delete-till-end-of-buffer ()
  "Deletes all text from mark until `end-of-buffer'."
  (interactive)
  (save-excursion
    (let ((beg (point)))
      (end-of-buffer)
      (delete-region beg (point)))))

(defun angrytuna-ido-find-project ()
  (interactive)
  (find-file
   (concat "~/Code/" (ido-completing-read "Project: "
                           (directory-files "~/Code/" nil "^[^.]")))))

(defun angrytuna-goto-config ()
  (interactive)
  (find-file "~/.emacs.d/angrytuna.el"))

;; fix kill-word
(defun angrytuna-kill-word (arg)
  "Special version of kill-word which swallows spaces separate from words"
  (interactive "p")

  (let ((whitespace-regexp "\\s-+"))
    (kill-region (point)
                 (cond
                  ((looking-at whitespace-regexp) (re-search-forward whitespace-regexp) (point))
                  ((looking-at "\n") (kill-line) (angrytuna-kill-word arg))
                  (t (forward-word arg) (point))))))

(defun angrytuna-backward-kill-word (arg)
  "Special version of backward-kill-word which swallows spaces separate from words"
  (interactive "p")
  (if (looking-back "\\s-+")
      (kill-region (point) (progn (re-search-backward "\\S-") (forward-char 1) (point)))
    (backward-kill-word arg)))

; set the mode based on the shebang;
; TODO: this sometimes breaks
(defun angrytuna-shebang-to-mode ()
  (interactive)
  (let*
      ((bang (buffer-substring (point-min) (prog2 (end-of-line) (point) (move-beginning-of-line 1))))
       (mode (progn
               (string-match "^#!.+[ /]\\(\\w+\\)$" bang)
               (match-string 1 bang)))
       (mode-fn (intern (concat mode "-mode"))))
    (when (functionp mode-fn)
      (funcall mode-fn))))
;(add-hook 'find-file-hook 'angrytuna-shebang-to-mode)

; duplicate the current line
(defun angrytuna-duplicate-line ()
  (interactive)
    (beginning-of-line)
    (copy-region-as-kill (point) (progn (end-of-line) (point)))
    (textmate-next-line)
    (yank)
    (beginning-of-line)
    (indent-according-to-mode))

; for loading libraries in from the vendor directory
(defun vendor (library)
  (let* ((file (symbol-name library))
         (normal (concat "~/.emacs.d/vendor/" file))
         (suffix (concat normal ".el"))
         (angrytuna (concat "~/.emacs.d/angrytuna/" file)))
    (cond
     ((file-directory-p normal) (add-to-list 'load-path normal) (require library))
     ((file-directory-p suffix) (add-to-list 'load-path suffix) (require library))
     ((file-exists-p suffix) (require library)))
    (when (file-exists-p (concat angrytuna ".el"))
      (load angrytuna))))

(defun angrytuna-backward-kill-line ()
  (interactive)
  (kill-line 0))

(require 'thingatpt)
(defun angrytuna-change-num-at-point (fn)
  (let* ((num (string-to-number (thing-at-point 'word)))
         (bounds (bounds-of-thing-at-point 'word)))
    (save-excursion
      (goto-char (car bounds))
      (angrytuna-kill-word 1)
      (insert (number-to-string (funcall fn num 1))))))

(defun angrytuna-inc-num-at-point ()
  (interactive)
  (angrytuna-change-num-at-point '+))

(defun angrytuna-dec-num-at-point ()
  (interactive)
  (angrytuna-change-num-at-point '-))

(defun url-fetch-into-buffer (url)
  (interactive "sURL:")
  (insert (concat "\n\n" ";; " url "\n"))
  (insert (url-fetch-to-string url)))

(defun url-fetch-to-string (url)
  (with-current-buffer (url-retrieve-synchronously url)
    (beginning-of-buffer)
    (search-forward-regexp "\n\n")
    (delete-region (point-min) (point))
    (buffer-string)))

(defun gist-buffer-confirm (&optional private)
  (interactive "P")
  (when (yes-or-no-p "Are you sure you want to Gist this buffer? ")
    (gist-region-or-buffer private)))

  (defun angrytuna-clean-slate ()
    "Kills all buffers except *scratch*"
    (interactive)
    (let ((buffers (buffer-list)) (safe '("*scratch*")))
      (while buffers
        (when (not (member (car buffers) safe))
          (kill-buffer (car buffers))
          (setq buffers (cdr buffers))))))

  (defun angrytuna/c-electric-brace (arg)
    "Inserts a closing curly, too."
    (interactive "*P")
    (c-electric-brace arg)
    (save-excursion
      (insert "\n")
      (insert "}")
      (indent-according-to-mode)))

;; from http://platypope.org/blog/2007/8/5/a-compendium-of-awesomeness
;; I-search with initial contents
(defvar isearch-initial-string nil)

(defun isearch-set-initial-string ()
  (remove-hook 'isearch-mode-hook 'isearch-set-initial-string)
  (setq isearch-string isearch-initial-string)
  (isearch-search-and-update))

(defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
  "Interactive search forward for the symbol at point."
  (interactive "P\np")
  (if regexp-p (isearch-forward regexp-p no-recursive-edit)
    (let* ((end (progn (skip-syntax-forward "w_") (point)))
           (begin (progn (skip-syntax-backward "w_") (point))))
      (if (eq begin end)
          (isearch-forward regexp-p no-recursive-edit)
        (setq isearch-initial-string (buffer-substring begin end))
        (add-hook 'isearch-mode-hook 'isearch-set-initial-string)
        (isearch-forward regexp-p no-recursive-edit)))))
