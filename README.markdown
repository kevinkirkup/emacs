Taken from Defunkt @ github
git://github.com/defunkt/emacs.git
Modified by angry-tuna

    (defun kts (emacs config)
      "chris wanstrath // chris@ozmm.org"
  
      (git-clone "git://github.com/angrytuna/emacs.git")
      (ruby "emacs/install.rb")
      (find-file "emacs/local.el")
      (insert '(load "angrytuna"))
      (save-buffer))
