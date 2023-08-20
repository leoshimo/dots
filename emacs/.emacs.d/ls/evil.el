;;
;; evil.el - Evil configuration
;;

;; evil - https://evil.readthedocs.io/en/latest/overview.html#installation-via-package-el
(use-package evil
  :diminish
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)

  ;; evil-search
  (evil-select-search-module 'evil-search-module 'evil-search)
  (setq evil-ex-search-persistent-highlight nil) ;; no highlight on exit

  ;; Swap ; / ;
  ;; (define-key evil-normal-state-map (kbd ";") 'evil-ex)
  ;; (define-key evil-normal-state-map (kbd ":") 'evil-repeat-find-char)

  ;; C-h (I) => Bksp
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Org TAB cycling
  (evil-define-key 'normal org-mode-map (kbd "t") #'org-cycle)
  (evil-define-key 'normal org-mode-map (kbd "T") #'org-shifttab))

;; evil-escape - https://github.com/syl20bnr/evil-escape
(use-package evil-escape
  :config
  (evil-escape-mode t)
  (setq evil-escape-excluded-major-modes '(magit-status-mode))
  (setq-default evil-escape-key-sequence "jk"))

;; evil-visualstar - https://github.com/bling/evil-visualstar
(use-package evil-visualstar
  :diminish
  :config
  (global-evil-visualstar-mode))

;; evil-commentary - https://github.com/linktohack/evil-commentary
(use-package evil-commentary
  :diminish
  :config
  (evil-commentary-mode))

;; evil-collection - https://github.com/emacs-evil/evil-collection
(use-package evil-collection
  :diminish
  :after evil
  :config
  (evil-collection-init))

;; evil-org - https://github.com/Somelauw/evil-org-mode
(use-package evil-org
  :hook (org-mode . evil-org-mode)
  :config
  (evil-org-set-key-theme '(textobjects insert navigation additional shift heading)))

