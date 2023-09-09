(add-to-list 'load-path "~/.emacs.d/ls/")
(load-library "straight")

(load-library "base")
(load-library "company")
(load-library "evil")
(load-library "dumb-jump")
(load-library "ls-gpt")
(load-library "keybindings")
(load-library "lisp")
(load-library "ls-elixir")
(load-library "ls-flyspell")
(load-library "lsp")
(load-library "magit")
(load-library "org")
(load-library "rust")
(load-library "terminal")
(load-library "theme")
(load-library "vertico")
(load-library "web")
(load-library "which-key")
(load-library "project")
(load-library "restclient")
(load-library "ls-hideshow")

;; (load-library "window-split")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(safe-local-variable-values '((magit-todos-depth . 0))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package lox-mode)
(use-package rec-mode)

(use-package lua-mode)
(recentf-mode)

;; rg (ripgrep) - https://github.com/dajva/rg.el
(use-package rg
  :config
  (rg-enable-default-bindings))

(setq undo-outer-limit 72000000)

(use-package janet-mode)
(straight-use-package '(janet
   :type git
   :host github
   :repo "serialdev/ijanet-mode")
)
