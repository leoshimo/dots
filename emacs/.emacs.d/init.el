;; Emacs Config

(add-to-list 'load-path "~/.emacs.d/ls/")
(load-library "straight")

(load-library "base")
(load-library "company")
(load-library "evil")
(load-library "dumb-jump")
(load-library "ls-gpt")
(load-library "keybindings")
(load-library "lisp")
(load-library "ls-elixir")
(load-library "ls-flyspell")
(load-library "lsp")
(load-library "magit")
(load-library "org")
(load-library "terminal")
(load-library "theme")
(load-library "vertico")
(load-library "web")
(load-library "which-key")
(load-library "project")
(load-library "restclient")
(load-library "ls-hideshow")
(load-library "window")
;; (load-library "window-split")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(safe-local-variable-values '((magit-todos-depth . 0))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package lox-mode)
(use-package rec-mode)

(use-package lua-mode)
(recentf-mode)

;; rg (ripgrep) - https://github.com/dajva/rg.el
(use-package rg
  :config
  (rg-enable-default-bindings))

(setq undo-outer-limit 72000000)

(straight-use-package '(janet
   :type git
   :host github
   :repo "serialdev/ijanet-mode")
)
(use-package janet-mode)

(define-derived-mode lyric-mode janet-mode "lyric")
(add-to-list 'auto-mode-alist '("\\.ll\\'" . lyric-mode))

(define-key c-mode-map (kbd "C-c C-c C-r")
            (lambda ()
              (interactive)
              (compile "make run")))
(define-key c-mode-map (kbd "C-c C-c C-b")
            (lambda ()
              (interactive)
              (compile "make build")))
(define-key c-mode-map (kbd "C-c C-c C-f")
            (lambda ()
              (interactive)
              (compile "make format")))
(define-key c-mode-map (kbd "C-c C-c C-c")
            (lambda ()
              (interactive)
              (compile "make clean")))

(use-package yaml-mode)

;; rustic - https://github.com/brotzeit/rustic
(use-package rustic
  :config
  (setq rustic-compile-backtrace 1)
  (setq rustic-compile-directory-method 'rustic-buffer-workspace)
  ;; sensible colors in term
  (setq rustic-ansi-faces ["black" "red2" "green3" "yellow3" "cyan2" "magenta3" "cyan3" "white"]))

(use-package wgrep
  :config
  (require 'wgrep))

;; -*- lexical-binding: t -*-

(use-package elfeed
  :bind (("C-x w" . elfeed))
  :config
  (setq elfeed-curl-program-name "curl")
  (setq elfeed-feeds
        '("https://lobste.rs"
          ("https://lobste.rs/t/rust.rss" rust)
          ("https://lobste.rs/t/elixir.rss" elixir)
          ("https://karthinks.com/index.xml" emacs)
          ("https://planet.emacslife.com/atom.xml" emacs))))

;; (setq elfeed-show-entry-switch #'elfeed-display-buffer)
;; (defun elfeed-display-buffer (buf &optional act)
;;   (pop-to-buffer buf)
;;   (set-window-text-height (get-buffer-window) (round (* 0.7 (frame-height)))))

(setq dired-auto-revert-buffer t)

(setq magit-save-repository-buffers 'dontask)

;; Decode HTML entities
(defun leoshimo/html-decode-entities (html)
  "Decode given HTML entities into strings into entities"
  (with-temp-buffer
    (save-excursion (insert html))
    (decode-coding-string (xml-parse-string) 'utf-8)))

;; Auto Link Title
;; From https://gist.github.com/jmn/34cd4205fa30ccf83f94cb1bc0198f3f
(defun leoshimo/url-get-title (url &optional descr)
  "Takes a URL and returns the value of the <title> HTML tag,
   Thanks to https://frozenlock.org/tag/url-retrieve/ for documenting url-retrieve"
  (let ((buffer (url-retrieve-synchronously url))
        (title nil))
    (save-excursion
      (set-buffer buffer)
      (goto-char (point-min))
      (search-forward-regexp "<title>\\([^<]+?\\)</title>")	
      (setq title (leoshimo/html-decode-entities (match-string 1)))
      (kill-buffer (current-buffer)))
    title))

(setq org-make-link-description-function 'leoshimo/url-get-title)

;; (use-package smartparens
;;   :hook (prog-mode text-mode markdown-mode)
;;   :config (require 'smartparens-config))

(defun leoshimo/cogni-on-region (start end prompt replace)
  "Run cogni on region. Prefix arg means replace region, instead of separate output buffer"
  (interactive "r\nsPrompt: \nP")
  (shell-command-on-region start end
                           (format "cogni -s \"%s\"" prompt)
                           nil replace))
(global-set-key (kbd "M-c") #'leoshimo/cogni-on-region)

(straight-use-package '(whisper
                        :type git
                        :host github
                        :repo "natrys/whisper.el"))

(use-package whisper
  :config
  (setq whisper-install-directory "/tmp/"
        whisper-model "base"
        whisper-language "en"
        whisper-translate nil))

(defun rk/get-ffmpeg-device ()
  "Gets the list of devices available to ffmpeg.
The output of the ffmpeg command is pretty messy, e.g.
  [AVFoundation indev @ 0x7f867f004580] AVFoundation video devices:
  [AVFoundation indev @ 0x7f867f004580] [0] FaceTime HD Camera (Built-in)
  [AVFoundation indev @ 0x7f867f004580] AVFoundation audio devices:
  [AVFoundation indev @ 0x7f867f004580] [0] Cam Link 4K
  [AVFoundation indev @ 0x7f867f004580] [1] MacBook Pro Microphone
so we need to parse it to get the list of devices.
The return value contains two lists, one for video devices and one for audio devices.
Each list contains a list of cons cells, where the car is the device number and the cdr is the device name."
  (unless (string-equal system-type "darwin")
    (error "This function is currently only supported on macOS"))

  (let ((lines (string-split (shell-command-to-string "ffmpeg -list_devices true -f avfoundation -i dummy || true") "\n")))
    (cl-loop with at-video-devices = nil
             with at-audio-devices = nil
             with video-devices = nil
             with audio-devices = nil
             for line in lines
             when (string-match "AVFoundation video devices:" line)
             do (setq at-video-devices t
                      at-audio-devices nil)
             when (string-match "AVFoundation audio devices:" line)
             do (setq at-audio-devices t
                      at-video-devices nil)
             when (and at-video-devices
                       (string-match "\\[\\([0-9]+\\)\\] \\(.+\\)" line))
             do (push (cons (string-to-number (match-string 1 line)) (match-string 2 line)) video-devices)
             when (and at-audio-devices
                       (string-match "\\[\\([0-9]+\\)\\] \\(.+\\)" line))
             do (push (cons (string-to-number (match-string 1 line)) (match-string 2 line)) audio-devices)
             finally return (list (nreverse video-devices) (nreverse audio-devices)))))

(defun rk/find-device-matching (string type)
  "Get the devices from `rk/get-ffmpeg-device' and look for a device
matching `STRING'. `TYPE' can be :video or :audio."
  (let* ((devices (rk/get-ffmpeg-device))
         (device-list (if (eq type :video)
                          (car devices)
                        (cadr devices))))
    (cl-loop for device in device-list
             when (string-match-p string (cdr device))
             return (car device))))

(defcustom rk/default-audio-device nil
  "The default audio device to use for whisper.el and outher audio processes."
  :type 'string)

(defun rk/select-default-audio-device (&optional device-name)
  "Interactively select an audio device to use for whisper.el and other audio processes.
If `DEVICE-NAME' is provided, it will be used instead of prompting the user."
  (interactive)
  (let* ((audio-devices (cadr (rk/get-ffmpeg-device)))
         (indexes (mapcar #'car audio-devices))
         (names (mapcar #'cdr audio-devices))
         (name (or device-name (completing-read "Select audio device: " names nil t))))
    (setq rk/default-audio-device (rk/find-device-matching name :audio))
    (when (boundp 'whisper--ffmpeg-input-device)
      (setq whisper--ffmpeg-input-device (format ":%s" rk/default-audio-device)))))

;; (use-package evil-smartparens
;;   :config
;;   (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode))
