;;
;; docker.el - Docker mgmt config
;;

;; docker - https://github.com/Silex/docker.el
(use-package docker
  :bind ("C-c d" . docker))

;; dockerfile-mode - https://github.com/spotify/dockerfile-mode
(use-package dockerfile-mode)

;; docker-compose-mode - https://github.com/meqif/docker-compose-mode
(use-package docker-compose-mode)
