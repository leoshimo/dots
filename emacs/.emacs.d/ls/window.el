
(defun my/split-window-sensibly (org-fun command &optional window)
  "Advice for `split-window-sensibly' to prioritize horizontal."
  (let ((window (or window (selected-window))))
    ;; if horizontal-splittable, do it, otherwise fall back to default behavior
    (if (window-splittable-p window t)
        (with-selected-window window
          (split-window-right))
      (funcall org-fun window))))
(advice-add #'split-window-sensibly :around #'my/split-window-sensibly)
