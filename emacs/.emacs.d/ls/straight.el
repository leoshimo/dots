;;
;; Package Management with straight / use-package
;;

;; straight.el - https://github.com/radian-software/straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use-package - https://github.com/jwiegley/use-package
(straight-use-package 'use-package)
(use-package straight
  :custom (straight-use-package-by-default t))

;; diminish.el - https://github.com/myrjola/diminish.el
(use-package diminish)
