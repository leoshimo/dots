;;
;; counsel.el - counsel / sweeper / ivy config
;;

;; ivy / counsel / swiper - https://github.com/abo-abo/swiper
(use-package ivy
  :diminish
  :config
  (ivy-mode 1))

(use-package counsel
  :config
  (counsel-mode 1))

;; counsel-projectile - https://github.com/ericdanan/counsel-projectile
(use-package counsel-projectile
  :diminish
  :config
  (counsel-projectile-mode))

;; ivy-rich - https://github.com/Yevgnen/ivy-rich
;; (use-package ivy-rich
;;   :after ivy
;;   :init
;;   (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
;;   :config
;;   (ivy-rich-mode 1))

