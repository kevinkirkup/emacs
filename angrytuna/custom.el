;; customization
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 305 t)
 '(aquamacs-tool-bar-user-customization nil t)
 '(cluck-fontify-style (quote plt))
 '(cluck-switch-to-scheme-method (quote other-window))
 '(cua-mode nil nil (cua-base))
 '(default-frame-alist
    (quote
     ((foreground-color . "white")
      (background-color . "black")
      (menu-bar-lines . 1)
      (font . "-apple-inconsolata-medium-r-normal--20-150-72-72-m-150-iso10646-1")
      (tool-bar-lines . 0))))
 '(display-time-mode nil)
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols match menu netsplit noncommands readonly ring scrolltobottom stamp track)))
 '(global-linum-mode t)
 '(javascript-shell-command "johnson")
 '(js2-auto-indent-flag nil)
 '(js2-basic-offset 2)
 '(js2-bounce-indent-flag t)
 '(js2-enter-indents-newline t)
 '(js2-strict-missing-semi-warning nil)
 '(ns-tool-bar-display-mode nil t)
 '(ns-tool-bar-size-mode nil t)
 '(python-honour-comment-indentation nil)
 '(ruby-deep-arglist nil)
 '(ruby-deep-indent-paren nil)
 '(ruby-deep-indent-paren-style nil)
 '(standard-indent 2)
 '(tabbar-mode nil nil (tabbar))
 '(text-mode-hook (quote (smart-spacing-mode)))
 '(visual-line-mode nil t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 150 :width normal :family "apple-inconsolata"))))
 '(autoface-default ((t (:inherit default :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 150 :width normal :family "apple-inconsolata"))))
 '(emacs-lisp-mode-default ((t (:inherit autoface-default))) t)
 '(js2-mode-default ((t (:inherit autoface-default))) t)
 '(minibuffer-prompt ((((background dark)) (:foreground "cyan" :height 150))))
 '(mode-line ((t (:inherit aquamacs-variable-width :background "grey75" :foreground "black" :width normal))))
 '(text-mode-default ((t (:inherit autoface-default)))))

;; Enable buffer narrow and widening
(put 'narrow-to-region 'disabled nil)

;; Tidy customization
(autoload 'tidy-buffer "tidy" "Run Tidy HTML parser on current buffer" t)
(autoload 'tidy-parse-config-file "tidy" "Parse the `tidy-config-file'" t)
(autoload 'tidy-save-settings "tidy" "Save settings to `tidy-config-file'" t)
(autoload 'tidy-build-menu  "tidy" "Install an options menu for HTML Tidy." t)

;; Cutomization for HTML Mode
(defun my-html-mode-hook () "Customize my html-mode."
  (tidy-build-menu html-mode-map)
  (local-set-key [(control c) (control c)] 'tidy-buffer)
  (setq sgml-validate-command "tidy"))

(add-hook 'html-mode-hook 'my-html-mode-hook)

;; Check custom-file compatibility
(when (and (boundp 'aquamacs-version-id)
	   (< (floor (/ aquamacs-version-id 10))
	   (floor (/ aquamacs-customization-version-id 10))))
  (defadvice frame-notice-user-settings (before show-version-warning activate)
    (defvar aquamacs-backup-custom-file nil "Backup of `custom-file', if any.")
    (setq aquamacs-backup-custom-file "~/.emacs.d/angrytuna/customizations.2.1.el")
    (let ((msg "Aquamacs options were saved by a more recent program version.
Errors may occur.  Save Options to overwrite the customization file. The original, older customization file was backed up to ~/.emacs.d/angrytuna/customizations.2.1.el."))
      (if window-system
	  (x-popup-dialog t (list msg '("OK" . nil) 'no-cancel) "Warning")
	(message msg)))))
;; End compatibility check
