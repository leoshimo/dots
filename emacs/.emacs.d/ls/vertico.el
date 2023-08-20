;;
;; vertico.el - Configuration for vertico, embark, consult, marginalia
;;

;; for straight to find vertico extensions
(straight-use-package '(vertico
                        :files (:defaults "extensions/*")
                        :includes (vertico-buffer
                                   vertico-directory
                                   vertico-flat
                                   vertico-indexed
                                   vertico-mouse
                                   vertico-quick
                                   vertico-repeat
                                   vertico-reverse)))

;; vertico - https://github.com/minad/vertico
(use-package vertico
  :init
  (vertico-mode)
  :bind (:map vertico-map
              ("C-f" . #'vertico-scroll-up)
              ("C-b" . #'vertico-scroll-down))
  :custom
  (setq vertico-cycle t))

(use-package vertico-buffer
  :after vertico)
(use-package vertico-mouse
  :after vertico)
(use-package vertico-quick
  :after vertico)
(use-package vertico-repeat
  :after vertico
  :config
  (add-hook 'minibuffer-setup-hook #'vertico-repeat-save))
(use-package vertico-directory
  :after vertico
  :bind (:map vertico-map
              ("RET" . #'vertico-directory-enter)
              ("DEL" . #'vertico-directory-delete-char)
              ("C-w" . #'vertico-directory-delete-word) ; more vim-y
              ("M-DEL" . #'vertico-directory-delete-word)))

(defun consult-ripgrep-at-point ()
  "Runs consult-ripgrep at point"
  (interactive)
  (consult-ripgrep nil (thing-at-point 'symbol)))

;; consult - https://github.com/minad/consult
(use-package consult
  :bind (("C-x b" . consult-buffer)))

;; embark - https://github.com/oantolin/embark/
(use-package embark
  :bind
  (("C-x C-x" . embark-act)         
   ("C-h B" . embark-bindings)) 
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc.  You may adjust the Eldoc
  ;; strategy, if you want to see the documentation from multiple providers.
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  )

(use-package embark-consult
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; orderless - https://github.com/oantolin/orderless
;; Orderless completion style
;; Optionally use the `orderless' completion style.
(use-package orderless
  :after vertico
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; marginalia - https://github.com/minad/marginalia/
;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :after vertico
  ;; The :init section is always executed.
  :init

  ;; Marginalia must be actived in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))


;; Recommended Emacs Tweaks
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  (setq read-extended-cmmand-predicate
        #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))
