;;
;; web.el - Web Config
;;

;; web-mode
(use-package web-mode
  :mode
  "\\.ts\\'"
  "\\.html?\\'"
  "\\.css?\\'"
  "\\.js\\'"
  :config
  (require 'web-mode))
  

;; emmet
(use-package emmet-mode
  :hook (web-mode . emmet-mode)
  :config
  (require 'emmet-mode))

;; typescript-mode - https://github.com/emacs-typescript/typescript.el
;; TODO Replace with tree-sitter in Emacs 29
(use-package typescript-mode
  :config
  (require 'ansi-color)
  (defun colorize-compilation-buffer ()
    (ansi-color-apply-on-region compilation-filter-start (point-max)))
  (add-hook 'compilation-filter-hook 'colorize-compilation-buffer))
