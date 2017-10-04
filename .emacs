
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 '(custom-enabled-themes (quote (wombat)))
 '(inhibit-startup-screen t))
(custom-set-faces)

(add-to-list 'load-path "~/.emacs.d/epitech")
(add-to-list 'load-path "~/.emacs.d/elpa/smooth-scrolling-20161002.1249")


(load "std.el")
(load "std_comment.el")

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

;;(add-hook 'c++-mode-hook 'irony-mode)
;;(add-hook 'c-mode-hook 'irony-mode)
;;(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'after-init-hook #'global-flycheck-mode)

;;(eval-after-load 'flycheck
  ;;'(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(defun my-c-mode-common-hook ()
  (setq flycheck-clang-include-path (list "include" "../include" "../../include" "../../../include" "../../../../include" "../../../../../include")))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
;; ----------------------------------
;;           EPITECH CONFIG
;; ----------------------------------
(add-to-list 'load-path "~/.emacs.d/lisp")
(load "std.el")
(load "std_comment.el")
