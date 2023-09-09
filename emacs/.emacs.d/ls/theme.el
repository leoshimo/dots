;;
;; theme.el - Visual themes
;;

;; Line numbers
(global-display-line-numbers-mode t)
(column-number-mode t)
(global-hl-line-mode t)
(setq global-hl-line-sticky-flag t)

;; modus-themes - https://protesilaos.com/emacs/modus-themes
(use-package modus-themes
  :config
  (load-theme 'modus-vivendi-tritanopia t)
  (setq modus-themes-to-toggle '(modus-vivendi-tritanopia modus-operandi-tinted))
)

;; smart-mode-line
(use-package smart-mode-line
  :config
  (setq sml/no-confirm-load-theme t
        sml/theme 'respectful)
  (sml/setup))
