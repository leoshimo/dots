;;
;; terminal.el - Terminal env config
;;

;; term
(use-package term
  :config
  (setq explicit-shell-file-name "zsh")
  (setq term-prompt-regexp "^\$ *"))

;; exec-path-from-shell - https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :diminish
  :if (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize))

;; multi-term.el https://github.com/manateelazycat/multi-term
(use-package multi-term
  :config
  (setq multi-term-dedicated-window-height 25)
  (setq multi-term-dedicated-select-after-open-p t))

;; No Line Numbers
(dolist (mode '(term-mode-hook
                 shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; eterm-256oolor - https://github.com/dieggsy/eterm-256color
(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))
