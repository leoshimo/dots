;;
;; company - Completions config
;;


; company - https://github.com/company-mode/company-mode
(use-package company
  ;; :hook (emacs-lisp-mode . company-mode)
  :init
  (setq company-idle-delay nil)
  :config
  (company-mode)
  (add-hook 'after-init-hook 'global-company-mode))

