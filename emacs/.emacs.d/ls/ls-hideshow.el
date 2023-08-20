;;
;; ls-hideshow - hide show prefs
;;

(use-package hideshow
  :hook (rustic-mode . hs-minor-mode)
  :config
  (setq hs-isearch-open t))
