;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "~/.emacs.d/lisp/")
(setq ring-bell-function 'ignore)
;; load emacs 24's package system. Add MELPA repository.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/plugins")
(require 'python-mode)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/") ; many packages won't show if using stable
   t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(python-mode elpy helm-projectile jedi-core helm-core jenkinsfile-mode jedi fingers request-deferred anaconda-mode python-environment auto-complete concurrent ctable epc el-get exec-path-from-shell virtualenvwrapper zoom auctex typescript-mode ag counsel projectile-speedbar go-mode lsp-ui lsp-mode use-package flycheck-demjsonlint flymake-json dumb-jump flycheck-pycheckers json-mode dockerfile-mode groovy-imports groovy-mode butler jenkins docker yaml-mode helm-ag undo-tree 0xc magit ivy helm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(projectile-mode +1)
;; (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; (define-key projectile-mode-map (kbd "C-c f") 'projectile-command-map)

;; (setq helm-projectile-fuzzy-match nil)
(require 'helm-projectile)
(helm-projectile-on)

;; (require 'helm-config)
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
(global-set-key (kbd "C-c p s g") 'helm-grep-do-git-grep)
(global-set-key (kbd "<f2>") 'magit-status)



(load-theme 'manoj-dark t)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

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
(add-hook 'programming-mode-hook 'lsp)

(use-package lsp-ui :ensure t)
(setq lsp-ui-sideline-enable nil)


;; https://github.com/emacs-helm/helm/issues/2175
(customize-set-variable 'helm-ff-lynx-style-map t)

(elpy-enable)

(defun my/base64-encode-region-no-break ()
  (interactive)
  (base64-encode-region (mark) (point) t))


(require 'auctex-latexmk)
    (auctex-latexmk-setup)

(defun python-prettyprint-region ()
  (interactive)
  (let ( (new-buffer-name "*pprint*") (selection (buffer-substring-no-properties (region-beginning) (region-end))))
    (if (bufferp new-buffer-name)
      (kill-buffer new-buffer-name))
    (call-process
     "python"
     nil
     new-buffer-name nil
     "-c"
     "import ast; import json; import sys; x=ast.literal_eval(sys.argv[1]); print(json.dumps(x,indent=4))"
     selection)
    (pop-to-buffer new-buffer-name)))

(set-face-attribute 'default nil :height 165)

(setq org-agenda-files (list "~/Development/iskra/agenda.org"))

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq exec-path (append exec-path '("~/.pyenv/bin")))

(setenv "WORKON_HOME" "~/.pyenv/versions")

(define-key minibuffer-local-completion-map (kbd "SPC") 'self-insert-command)
(setq elpy-rpc-virtualenv-path 'current)
