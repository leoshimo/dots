;;
;; lsp.el - LSP configuration
;;

;; lsp-mode
;; Reference: https://lupan.pl/dotemacs/
(use-package lsp-mode
  :diminish lsp-mode
  :hook ((c-mode c++-mode js-mode typescript-mode web-mode elixir-mode)
         . lsp)
  :init
  (setq lsp-keymap-prefix "M-l"
        lsp-rust-analyzer-proc-macro-enable t
        lsp-lens-place-position 'above-line)
  :config
  (setq lsp-lens-enable nil)
  (lsp-enable-which-key-integration t))

;; lsp-ui - https://github.com/emacs-lsp/lsp-ui
(use-package lsp-ui
  :init
  (setq lsp-ui-doc-position 'at-point
        lsp-ui-doc-show-with-mouse nil)
  :bind (("C-c d" . lsp-ui-doc-show)
         ("C-c I" . lsp-ui-imenu)))

