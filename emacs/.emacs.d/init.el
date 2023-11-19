;; Emacs Config

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
(load-library "terminal")
(load-library "theme")
(load-library "vertico")
(load-library "web")
(load-library "which-key")
(load-library "project")
(load-library "restclient")
(load-library "ls-hideshow")
(load-library "window")
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

(define-derived-mode lyric-mode janet-mode "lyric")
(add-to-list 'auto-mode-alist '("\\.ll\\'" . lyric-mode))

(define-key c-mode-map (kbd "C-c C-c C-r")
            (lambda ()
              (interactive)
              (compile "make run")))
(define-key c-mode-map (kbd "C-c C-c C-b")
            (lambda ()
              (interactive)
              (compile "make build")))
(define-key c-mode-map (kbd "C-c C-c C-f")
            (lambda ()
              (interactive)
              (compile "make format")))
(define-key c-mode-map (kbd "C-c C-c C-c")
            (lambda ()
              (interactive)
              (compile "make clean")))

(use-package yaml-mode)

;; rustic - https://github.com/brotzeit/rustic
(use-package rustic
  :config
  (setq rustic-compile-backtrace 1)
  (setq rustic-compile-directory-method 'rustic-buffer-workspace)
  ;; sensible colors in term
  (setq rustic-ansi-faces ["black" "red2" "green3" "yellow3" "cyan2" "magenta3" "cyan3" "white"]))

;; -*- lexical-binding: t -*-

(use-package elfeed
  :bind (("C-x w" . elfeed))
  :config
  (setq elfeed-curl-program-name "curl")
  (setq elfeed-feeds
        '("https://lobste.rs"
          ("https://lobste.rs/t/rust.rss" rust)
          ("https://lobste.rs/t/elixir.rss" elixir)
          ("https://karthinks.com/index.xml" emacs)
          ("https://planet.emacslife.com/atom.xml" emacs))))

;; (setq elfeed-show-entry-switch #'elfeed-display-buffer)
;; (defun elfeed-display-buffer (buf &optional act)
;;   (pop-to-buffer buf)
;;   (set-window-text-height (get-buffer-window) (round (* 0.7 (frame-height)))))
