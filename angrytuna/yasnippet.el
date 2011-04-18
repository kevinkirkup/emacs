(add-to-list 'load-path
                "~/.emacs.d/vendor/yasnippet")

(require 'yasnippet)
(require 'dropdown-list)

(yas/global-mode 1)
(yas/initialize)

;; Load the snippets from snippets directory
(yas/load-directory "~/.emacs.d/vendor/yasnippet/snippets")

;; Activate the following prompts
(setq yas/prompt-functions '(yas/ido-prompt
                             yas/dropdown-prompt
                             yas/completing-prompt))

;; Replace yasnippets's TAB
;;(add-hook 'yas/minor-mode-hook
;;          (lambda () (define-key yas/minor-mode-map
;;                       (kbd "TAB") 'smart-tab))) ; was yas/expand
