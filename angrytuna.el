(add-to-list 'load-path "~/.emacs.d/vendor")

;; custom place to save menu customizations
(setq custom-file "~/.emacs.d/angrytuna/custom.el")
(when (file-exists-p custom-file) (load custom-file))

(when (file-exists-p ".passwords") (load ".passwords"))

(load "angrytuna/lisp")
(load "angrytuna/global")
(load "angrytuna/defuns")
(load "angrytuna/bindings")
(load "angrytuna/modes")
(load "angrytuna/theme")
(load "angrytuna/temp_files")
(load "angrytuna/github")
(load "angrytuna/git")
(load "angrytuna/todo")
(load "angrytuna/coffee")
(load "angrytuna/yasnippet")

(when (file-exists-p "angrytuna/private")
  (load "angrytuna/private"))

(vendor 'ack)
(vendor 'cheat)
(vendor 'magit)
(vendor 'gist)
(vendor 'growl)
(vendor 'textile-mode)
(vendor 'yaml-mode)
(vendor 'tpl-mode)
(vendor 'open-file-in-github)
(vendor 'ooc-mode)
(vendor 'coffee-mode)
(vendor 'auto-complete)

(load "angrytuna/auto-complete")
