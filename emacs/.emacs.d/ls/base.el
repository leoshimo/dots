;;
;; base - Global Base Config
;;

;; emacs base
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq delete-by-moving-to-trash t)
(setq dired-use-ls-dired nil)
(setq recentf-max-saved-items 100)

(setq-default truncate-lines nil)
(setq-default fill-column 80)
(setq-default indicate-empty-lines t)
(setq-default require-final-newline t)

;; mouse in term
(xterm-mouse-mode 1)

;; scratch is org
(setq initial-major-mode 'org-mode)

;; tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; GUI Cleanup
(menu-bar-mode -1)
(tooltip-mode -1)
(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)
      (scroll-bar-mode -1)))

;; Visual bell
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; All y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Filter non-file and dired buffers when cycling
(set-frame-parameter (selected-frame) 'buffer-predicate
                     (lambda (buf)
                       (let ((name (buffer-name buf))
                             (major-mode (buffer-local-value 'major-mode buf)))
                         (not (or (string-prefix-p "*" name)
                                  (eq 'dired-mode major-mode)
                                  (string-prefix-p "dired" (symbol-name major-mode))
                                  (string-prefix-p "magit" (symbol-name major-mode)))))))

;; dash.el - https://github.com/magnars/dash.el
(use-package dash)

;; command-log-mode - https://github.com/lewang/command-log-mode
(use-package command-log-mode
  :config
  (setq command-log-mode-open-log-turns-on-mode t)
  (setq command-log-mode-key-binding-open-log nil))

;; backups
(setq
   backup-by-copying t
   backup-directory-alist '(("." . "~/.saves/"))    
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       

;; no-littering - https://github.com/emacscollective/no-littering
(use-package no-littering
  :init
  (setq no-littering-etc-directory
        (expand-file-name "config/" user-emacs-directory))
  (setq no-littering-var-directory
        (expand-file-name "data/" user-emacs-directory))
  (setq auto-save-file-name-transforms `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
  (require 'no-littering))

;; xclip - https://elpa.gnu.org/packages/xclip.html
(use-package xclip
  :config
  (xclip-mode 1))

;; flycheck - https://github.com/flycheck/flycheck
(use-package flycheck
  :defer)

(use-package volatile-highlights
  :config
  (volatile-highlights-mode t))

(use-package browse-kill-ring)

;; Persist history
(use-package savehist
  :init
  (savehist-mode))

;; winner-mode
(winner-mode t)
