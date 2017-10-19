
;;Emacs Configuration of Léo Labruyere AKA Cadichon AKA Pomme DeTerre AKA Jean-Maghrebin
;;Help you to make norme-complient program in C (norme 2017)
;;Thanks to Cocadev for the 80 characters check

(package-initialize)

(custom-set-variables
 '(inhibit-startup-screen t))
(custom-set-faces)

(add-to-list 'load-path "~/.emacs.d/epitech")
(add-to-list 'load-path "~/.emacs.d/smooth-scrolling")
(add-to-list 'load-path "~/.emacs.d/column-marker")


(load "std.el")
(load "std_comment.el")
(load "column-marker.el")
(load "smooth-scrolling.el")

;;(setq select-enable-clipboard t)
;;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
(put 'upcase-region 'disabled nil)
(setq column-number-mode t)
(show-paren-mode 1)
(global-linum-mode 1)
(setq linum-format "%4d \u2502 ")
(custom-set-faces '(linum ((t (:foreground "grey")))))
(setq show-trailing-whitespace t)
(setq-default show-trailing-whitespace t)
(add-hook 'c-mode-hook '(lambda () (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(require 'smooth-scrolling)
(smooth-scrolling-mode 1)

(require 'column-marker)
(add-hook 'c-mode-hook (lambda () (interactive) (column-marker-2 80)))

;;(add-hook 'c++-mode-hook 'irony-mode)
;;(add-hook 'c-mode-hook 'irony-mode)
;;(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'after-init-hook #'global-flycheck-mode)

;;(eval-after-load 'flycheck
  ;;'(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(defun copy-to-clipboard ()
  (interactive)
  (if (display-graphic-p)
      (progn
        (message "Yanked region to x-clipboard!")
        (call-interactively 'clipboard-kill-ring-save)
        )
    (if (region-active-p)
        (progn
          (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
          (message "Yanked region to clipboard!")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!")))
  )

(defun my-copy-to-xclipboard(arg)
  (interactive "P")
  (cond
    ((not (use-region-p))
      (message "Nothing to yank to X-clipboard"))
    ((and (not (display-graphic-p))
         (/= 0 (shell-command-on-region
                 (region-beginning) (region-end) "xsel -i -b")))
      (error "Is program `xsel' installed?"))
    (t
      (when (display-graphic-p)
        (call-interactively 'clipboard-kill-ring-save))
      (message "Yanked region to X-clipboard")
      (when arg
        (kill-region  (region-beginning) (region-end)))
      (deactivate-mark))))

(defun my-cut-to-xclipboard()
  (interactive)
  (my-copy-to-xclipboard t))

(defun my-paste-from-xclipboard()
  "Uses shell command `xsel -o' to paste from x-clipboard. With
one prefix arg, pastes from X-PRIMARY, and with two prefix args,
pastes from X-SECONDARY."
  (interactive)
  (if (display-graphic-p)
    (clipboard-yank)
   (let*
     ((opt (prefix-numeric-value current-prefix-arg))
      (opt (cond
       ((=  1 opt) "b")
       ((=  4 opt) "p")
       ((= 16 opt) "s"))))
     (insert (shell-command-to-string (concat "xsel -o -" opt))))))


(global-set-key (kbd "C-w") 'my-cut-to-xclipboard)
(global-set-key (kbd "M-w") 'my-copy-to-xclipboard)
(global-set-key (kbd "C-y") 'my-paste-from-xclipboard)

(defun my-c-mode-common-hook ()
  (setq flycheck-clang-include-path (list "include" "../include" "../../include" "../../../include" "../../../../include" "../../../../../include")))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
