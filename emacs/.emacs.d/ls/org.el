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
