
;; Default ctags/etags file name
(setq tags-file-name "TAGS")

;; Default Tab-Width to 2 spaces
(setq-default tab-width 2)

;; Insert Spaces instead of tabs unless overriden by mode
(setq-default indent-tabs-mode nil)

;; Emulate 3 mouse buttons
(setq mac-emulate-three-button-mouse nil)

;; Disable Common User Adjustment trasient mark mode
;; and make sure it starts off disabled.
(setq cua-highlight-region-shift-only t)
(cua-mode nil)

;; Use UTF-8 Encoding
(prefer-coding-system 'utf-8)

;; Disable Version control
(setq vc-handled-backends nil)

;; View Gist using browse-url
(setq gist-view-gist t)

;; Explicitly show the end of a buffer
(set-default 'indicate-empty-lines t)

;; Visible Bell
(setq visible-bell t)

;; Show both parenthesis when one is highlighted
(show-paren-mode t)

;; Put backup files in a separate directory
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Delete traling whitespace on exit
(add-hook 'before-save-hook
          (lambda () (delete-trailing-whitespace)))

;; Set the C Idention style
(setq c-default-style "k&r"
      c-basic-offset 2)

; Add the Macports bin directory to the path, along with the local bin directory
(setenv "PATH"
  (concat "/opt/local/bin:~/bin:" (getenv "PATH")))
(setq exec-path (append '("/opt/local/bin") exec-path))
;; (setq ns-command-modifier (quote meta))
;; (setq ns-alternate-modifier (quote meta))

;; works in both aquamacs and carbon
(when (functionp 'tool-bar-mode)
  (tool-bar-mode -1))

;; aquamacs specific
(when (boundp 'aquamacs-version)
  (one-buffer-one-frame-mode 0))

;; Add remember mode to Org-Mode
(org-remember-insinuate)