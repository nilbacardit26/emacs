;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "~/.emacs.d/lisp/")
(setq ring-bell-function 'ignore)
;; load emacs 24's package system. Add MELPA repository.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (counsel projectile-speedbar go-mode lsp-ui lsp-mode use-package flycheck-demjsonlint flymake-json dumb-jump flycheck-pycheckers json-mode dockerfile-mode groovy-imports groovy-mode butler jenkins docker yaml-mode helm-ag undo-tree 0xc elpy magit ivy helm-projectile helm projectile))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; (setq helm-projectile-fuzzy-match nil)
(require 'helm-projectile)
(helm-projectile-on)

(require 'helm-config)
(helm-mode 1)
(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(define-key global-map [remap execute-extended-command] 'helm-M-x)
(unless (boundp 'completion-in-region-function)
  (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
  (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))

(ivy-mode 1)



;; load the packaged named swiper.
(load "swiper.el") ;; best not to include the ending “.el” or “.elc”
(load "swiper-helm.el") ;; best not to include the ending “.el” or “.elc”

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-r") 'swiper)
(global-set-key (kbd "<f2>") 'magit-status)


(load-theme 'manoj-dark t)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

(elpy-enable)

(add-hook 'shell-mode-hook
      (lambda ()
        (face-remap-set-base 'comint-highlight-prompt :inherit nil)))

(dumb-jump-mode +1)

(undo-tree-mode 1)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key [remap list-buffers] 'ibuffer)

(push (cons "\\*shell\\*" display-buffer--same-window-action) display-buffer-alist)

(use-package lsp-mode :ensure t)
;; in case you are using client which is available as part of lsp refer to the
;; table bellow for the clients that are distributed as part of lsp-mode.el
(require 'lsp-clients)
(add-hook 'programming-mode-hook 'lsp)

(use-package lsp-ui :ensure t)
(setq lsp-ui-sideline-enable nil)

(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(use-package company-lsp
  :after (company lsp-mode)
  :config
  (add-to-list 'company-backends 'company-lsp)
  :custom
  (company-lsp-async t)
  (company-lsp-enable-snippet t))

;; https://github.com/emacs-helm/helm/issues/2175
(customize-set-variable 'helm-ff-lynx-style-map t)


(progn
  ;; make buffer switch command do suggestions, also for find-file command
  (require 'ido)
  (ido-mode 1)

  ;; show choices vertically
  (if (version< emacs-version "25")
      (progn
        (make-local-variable 'ido-separator)
        (setq ido-separator "\n"))
    (progn
      (make-local-variable 'ido-decorations)
      (setf (nth 2 ido-decorations) "\n")))

  ;; show any name that has the chars you typed
  (setq ido-enable-flex-matching t)
  ;; use current pane for newly opened file
  (setq ido-default-file-method 'selected-window)
  ;; use current pane for newly switched buffer
  (setq ido-default-buffer-method 'selected-window)
  ;; stop ido from suggesting when naming new file
  (define-key (cdr ido-minor-mode-map-entry) [remap write-file] nil))

(require 'company-lsp)
(push 'company-lsp company-backends)

;; Automatically activate pyenv
(require 'pyenv-mode-auto)

(defun my/base64-encode-region-no-break ()
  (interactive)
  (base64-encode-region (mark) (point) t))
