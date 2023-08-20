;;
;; magit
;;

;; magit - https://github.com/magit/magit
(use-package magit)

;; magit-todos - https://github.com/alphapapa/magit-todos
(use-package magit-todos
  :after magit
  :config
  (magit-todos-mode))
