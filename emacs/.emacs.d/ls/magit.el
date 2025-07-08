;;
;; magit
;;

;; magit - https://github.com/magit/magit
(use-package magit
  :custom
  (magit-git-executable "/opt/homebrew/bin/git"))

;; magit-todos - https://github.com/alphapapa/magit-todos
;; (use-package magit-todos
;;   :after magit
;;   :config
;;   (magit-todos-mode))

;; for perf profiling into *Message*
;; (magit-toggle-verbose-refresh)
