;;
;; keybindings.el - keybindings
;;

;; general.el - https://github.com/noctuid/general.el
(use-package general
  :config

  ;; swap ; and :
  (general-swap-key nil 'motion
    ";" ":")

  (general-define-key
   :states 'insert
   ;; "TAB" 'tab-to-tab-stop ;; opt-out of indent-for-tab-command
   "C-k" 'company-indent-or-complete-common)

  (general-define-key
   :states '(normal visual)
   :prefix "SPC"
   :keymaps 'override

   "x" '(execute-extended-command :which-key "M-x")
   "SPC" '(vertico-repeat :which-key "Repeat last")

   ;; comments
   "c" '(:ignore t :which-key "Comment")
   "cl" '(comment-or-uncomment-region-or-line :which-key "comment line")

   ;; file / buffer
   "f" '(:ignore t :which-key "Files")
   "ff" '(project-find-file :which-key "File (Project)")
   "fo" '(find-file-other-window :which-key "File (Other)")
   "fr" '(consult-recent-file :which-key "File (RecentF)")
   "fs" '(toggle-scratch-org-other-window :which-key "Org Scratch")
   "fS" '(toggle-scratch-other-window :which-key "Scratch")
   "fl" '(toggle-log-org-other-window :which-key "Org Log")

   ;; gptel
   "og" '(toggle-gptel-other-window :which-key "Toggle GPT")

   "i" '(consult-imenu :which-key "imenu")
   "I" '(consult-imenu-multi :which-key "imenu (multi)")

   ;; bookmark
   "m" '(:ignore t :which-key "Bookmark")
   "mm" '(consult-bookmark :which-key "Bookmark")
   "ms" '(bookmark-set :which-key "Set")
   "md" '(bookmark-delete :which-key "Delete")
   "mD" '(bookmark-delete-all :which-key "Delete all")

   ;; code action
   "l" '(:ignore t :which-key "Lsp")
   "la" '(lsp-execute-code-action :which-key "Code Action")
   "ca" '(lsp-execute-code-action :which-key "Code Action") ; muscle memory

   ;; yank
   "y" '(consult-yank-pop :which-key "Yank Pop")

   ;; project
   "p" '(:ignore t :which-key "Project")
   "pp" '(project-switch-project :which-key "Switch")

   ;; search
   "s" '(:ignore t :which-key "Search")
   "sf" '(consult-find :which-key "Find")
   "ss" '(consult-ripgrep :which-key "Ripgrep")
   "sS" '(consult-ripgrep-at-point :which-key "Ripgrep")
   "sl" '(consult-line :which-key "Search Line")
   "sL" '(consult-line-multi :which-key "Search Line (multi)")
   "so" '(consult-outline :which-key "Outline")
   "sj" '(evil-collection-consult-jump-list :which-key "Jump List")

   ;; git
   "g" '(:ignore t :which-key "Git")
   "gs" '(magit-status :which-key "Status")
   "gh" '(magit-status-here :which-key "Status (Here)")
   "gc" '(:ignore t :which-key "Checkout")
   "gco" '(magit-branch-and-checkout :which-key "Branch")
   "gcf" '(magit-file-checkout :which-key "File")
   "gl" '(:ignore t :which-key "Log")
   "gla" '(magit-log-all :which-key "All")
   "gll" '(magit-log-current :which-key "Current File")
   "gt" '(magit-todos-list :which-key "Todos")

   ;; docker
   "d" '(docker :which-key "Docker")

   ;; hydra
   "t" '(hydra-toggle/body :which-key "Toggle")
   "b" '(hydra-buffer/body t :which-key "Buffer")
   "e" '(hydra-error/body t :which-key "Errors")
   "w" '(hydra-window/body :which-key "Windows")

   ;; term
   "ot" '(multi-term-dedicated-toggle :which-key "toggle term")
   "oT" '(multi-term :which-key "new term")
   )

  ;; Org
  (general-define-key
   :states 'normal
   :keymaps 'org-mode-map
   :prefix "SPC"
   "o" '(:ignore t :which-key "Org")
   "ol" '(org-store-link :which-key "Link")
   "oa" '(org-agenda :which-key "Agenda")
   "oc" '(org-capture :which-key "Capture")
   "os" '(org-sparse-tree :which-key "Sparse Tree")
   "oe" '(org-export-dispatch :which-key "Export")
   "oh" '(org-insert-heading :which-key "Heading")
   )

  ;; Org-src
  (general-define-key
   :states 'insert
   :keymaps 'org-src-mode-map
   "TAB" 'tab-to-tab-stop ;; opt-out of indent-for-tab-command
   )

  ;; elixir - RUN
  (general-define-key
   :states 'normal
   :keymaps 'elixir-mode-map
   :prefix "SPC"
   "r" '(:ignore t :which-key "Alchemist")
   "rx" '(alchemist-mix :which-key "Mix")
   "rt" '(:ignore t :which-key "Test")
   "rtt" '(exunit-verify-all :which-key "All")
   "rts" '(exunit-verify-single :which-key "Single"))
   )


;; hydra - https://github.com/abo-abo/hydra
(use-package hydra
  :config
  (defhydra hydra-buffer (:color blue :columns 3)
    "Buffers"
    ("n" next-buffer "next" :color red)
    ("p" previous-buffer "prev" :color red)
    ("b" consult-buffer "switch")
    ("B" ibuffer "ibuffer")
    ("C-b" buffer-menu "buffer menu")
    ("N" evil-buffer-new "new")
    ("d" kill-this-buffer "delete" :color red)

    ("j" evil-scroll-down "scroll down" :exit nil)
    ("k" evil-scroll-up "scroll up" :exit nil)
    ("J" scroll-other-window-down "scroll down (other)" :exit nil)
    ("K" scroll-other-window "scroll up (other)" :exit nil)

    ;; don't come back to previous buffer after delete
    ("D" (progn (kill-this-buffer) (next-buffer)) "Delete" :color red)
    ("s" save-buffer "save" :color red)
    ("q" nil "quit" :color blue))


  (defhydra hydra-toggle (:hint nil :color blue :columns 1)
    "TOGGLE"
    ("f" follow-mode "follow-mode")
    ("s" flyspell-mode "flyspell")
    ("l" toggle-truncate-lines "Truncate Lines")
    ("t" modus-themes-toggle "Toggle Theme")
    ("T" consult-theme "Select Theme")
    ("w" toggle-word-wrap "Word Wrap")
    ("e" electric-indent-mode "Electric Indent")
    ("q" nil "quit" :color blue))

  (defhydra hydra-error (:hint nil :colur blue :columns 1)
    "goto-error"
    ("h" first-error "first")
    ("j" next-error "next")
    ("k" previous-error "prev")
    ("n" next-error "next")
    ("p" previous-error "prev")
    ("v" recenter-top-bottom "recenter")
    ("q" nil "quit"))

  (defhydra hydra-window (:color red :hint nil)
  "
 Split: _v_ert _h_:horz
Delete: _o_nly  _d_elete 
  "
  ("h" windmove-left)
  ("j" windmove-down)
  ("k" windmove-up)
  ("l" windmove-right)

  ("p" winner-undo)
  ("n" 'winner-redo)

  ("H" (hydra-move-splitter-left 15))
  ("J" (hydra-move-splitter-down 8))
  ("K" (hydra-move-splitter-up 8))
  ("L" (hydra-move-splitter-right 15))
  ("v" (lambda ()
         (interactive)
         (split-window-right)
         (windmove-right)))
  ("h" (lambda ()
         (interactive)
         (split-window-below)
         (windmove-down)))
  ("o" delete-other-windows :exit t)
  ("d" delete-window)
  ("q" nil)
  ;("i" ace-maximize-window "ace-one" :color blue)
  ;("b" ido-switch-buffer "buf")
  ("m" headlong-bookmark-jump))
  )
;; key-chord - https://github.com/emacsorphanage/key-chord
(use-package key-chord
  :diminish
  :init
  (setq key-chord-two-keys-delay 0.5)
  :config
  (key-chord-define evil-normal-state-map "[w" 'winner-undo)
  (key-chord-define evil-normal-state-map "]w" 'winner-redo)
 
  (key-chord-define evil-normal-state-map "[c" 'previous-error)
  (key-chord-define evil-normal-state-map "]c" 'next-error)
  (key-chord-define evil-normal-state-map "[C" 'first-error)
  (key-chord-mode t))


(defun hydra-move-splitter-left (arg)
  "Move window splitter left."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'right))
      (shrink-window-horizontally arg)
    (enlarge-window-horizontally arg)))

(defun hydra-move-splitter-right (arg)
  "Move window splitter right."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'right))
      (enlarge-window-horizontally arg)
    (shrink-window-horizontally arg)))

(defun hydra-move-splitter-up (arg)
  "Move window splitter up."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'up))
      (enlarge-window arg)
    (shrink-window arg)))

(defun hydra-move-splitter-down (arg)
  "Move window splitter down."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'up))
      (shrink-window arg)
    (enlarge-window arg)))

(defun toggle-scratch-other-window ()
  "Toggle scratch buffer in other window"
  (interactive)
  (if (not (string= "*scratch*" (buffer-name)))
      (progn
        (setq toggle-scratch-prev-buffer (buffer-name))
	    (pop-to-buffer (get-scratch-buffer-create)))
    (delete-windows-on "*scratch*")))

(defun toggle-gptel-other-window ()
  "Toggle scratch buffer in other window"
  (interactive)
  (if (not (string= "*ChatGPT*" (buffer-name)))
      (pop-to-buffer (gptel "*ChatGPT*" (getenv "OPENAI_API_KEY")))
    (delete-windows-on "*ChatGPT*")))

(defun toggle-scratch-org-other-window ()
  "Toggle the scratch org buffer in other window"
  (interactive)
  (let* ((filepath "~/proj/org/scratch.org")
         (buf (find-buffer-visiting filepath)))
    (if (and buf (get-buffer-window buf))
        (delete-window (get-buffer-window buf))
        (find-file-other-window filepath))))

(defun toggle-log-org-other-window ()
  "Toggle the log org buffer in other window"
  (interactive)
  (let* ((filepath "~/proj/org/log.org")
         (buf (find-buffer-visiting filepath)))
    (if (and buf (get-buffer-window buf))
        (delete-window (get-buffer-window buf))
        (find-file-other-window filepath))))
