;;
;; rust.el - Rust Emacs Configuration
;;

;; rust-mode - https://github.com/rust-lang/rust-mode
;; (use-package rust-mode)

;; rustic - https://github.com/brotzeit/rustic
(use-package rustic
  :config
  (setq rustic-compile-directory-method 'rustic-buffer-workspace))
