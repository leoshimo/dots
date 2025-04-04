;;
;; org.el - org-mode config
;;

(use-package org
  :hook ((org-mode . auto-fill-mode)
         (org-mode . flyspell-mode))
  ;; :hook ((org-mode . auto-fill-mode)
  ;;        (org-mode . flyspell-mode)
  ;;        (org-mode . org-indent-mode))
  :config
  (require 'org-tempo)
  (require 'org-src)
  (setq org-babel-confirm-evaluate nil)
  (setq org-edit-src-content-indentation 0)
  (setq org-imenu-depth 8)
  (setq org-list-indent-offset 1)
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-startup-folded t)
  (setq org-startup-indented t)

  (setq org-todo-keywords '((sequence "TODO(t)" "WIP(w)" "NEXT(n)" "OPEN(o)" "|" "DONE(d)" "MOVE(m)" "KILL(k)")))
  (setq org-todo-keyword-faces
    '(("WIP" . org-priority)
      ("NEXT" . org-priority)
      ("DONE" . '(shadow org-todo)) 
      ("MOVE" . '(shadow org-todo)) 
      ("KILL" . '(shadow org-todo))))

  (set-face-attribute 'org-headline-done nil 
                      :strike-through t 
                      :foreground "light gray")

  (setq org-fontify-done-headline t)

  (with-eval-after-load 'outline
    (add-hook 'ediff-prepare-buffer-hook #'org-show-all))
  (setq org-babel-python-command "/usr/bin/python3")
  (org-babel-do-load-languages 'org-babel-load-languages
     '(
       (C . t)
       (emacs-lisp . t)
       (js . t)
       (typescript . t)
       (lisp . t)
       (python . t)
       (restclient . t)
       (shell . t))))


;; ob-restclient - https://github.com/alf/ob-restclient.el
(use-package ob-restclient)
  
;; ob-typescript - https://github.com/lurdan/ob-typescript
(use-package ob-typescript)
