;;
;; project.el config
;;

;; project.el
(use-package project
  :config
  (setq project-switch-commands '((project-find-file "Find File" ?f)
                                  (project-dired "Dired" ?d)
                                  (consult-ripgrep "Ripgrep" ?s)
                                  (magit-project-status "Git" ?g))))
