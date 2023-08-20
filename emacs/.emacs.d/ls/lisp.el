;;
;; lisp.el - Lisp Settings
;;

(use-package slime
  :config
  (setq inferior-lisp-program "clisp")
  (require 'slime-autoloads)
  (slime-setup '(slime-fancy)))
