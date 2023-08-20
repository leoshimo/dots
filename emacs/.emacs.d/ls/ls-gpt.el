;;
;; gpt.el - GPT integrations
;;

;; gptel - https://github.com/karthink/gptel/tree/6c47c0a48306e127557caf54c5a03e162e2d2ed3
(use-package gptel
  :init
  (setq gptel-model "gpt-4")
  (setq gptel-default-mode 'org-mode)
  (setq gptel-stream 't)
  (setq gptel-api-key (getenv "OPENAI_API_KEY")))

