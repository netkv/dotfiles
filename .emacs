;;; config da garbagæ
;; I have no idea what i am doing

;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)
;; Lower threshold back to 8 MiB (default is 800kB)
(add-hook 'emacs-startup-hook
(lambda ()
  (setq gc-cons-threshold (expt 2 23))))
(load-theme 'bloat t)
;;colours something idk
;theme

(set-face-attribute 'menu nil
                    :inverse-video nil
                    :background "#bb2040"
                    :foreground "#ffaacc")
(face-spec-set 'mode-line
  '((((class color) (min-colors 88))
     :box (:line-width -1 :style released-button)
     )
    (t
     :inverse-video t)))
(tool-bar-mode -1)
(set-fringe-mode 0)
(face-spec-set 'mode-line-inactive
  '((default
     :inherit mode-line)
    (((class color) (min-colors 88) (background light))
     ;;:weight light
     ;;:box (:line-width -1 :color "#222222" :style nil)
     :foreground "#aaaaaa" :background "#161616")
    (((class color) (min-colors 88) (background dark))
     :background "#ff161616" :foreground "gray70" :box nil)))

;; HIGHLIGHT GUIDES CONFIG
(add-hook 'highlight-indent-guides-mode-hook
		  (lambda()
			(set-face-background 'highlight-indent-guides-odd-face "#222222")
			(set-face-background 'highlight-indent-guides-even-face "#222222")
			(set-face-foreground 'highlight-indent-guides-character-face "#222222")
			)
		  )
;indent look
(defface my-highlighter-even-face '((t :foreground "#602030")) "")
(defface my-highlighter-odd-face '((t :foreground "#224433")) "")

(defun my-highlighter (level responsive display)
  (if (cl-evenp level)
      'my-highlighter-even-face
    'my-highlighter-odd-face))
(setq highlight-indent-guides-highlighter-function 'my-highlighter)


(face-spec-set 'mode-line-highlight
  '((((class color) (min-colors 88))g
    :foreground "red")
    (t
     :inherit highlight)))
(require 'rust-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9b9d8de5a513a98a03b671b6033e7ba2261c7a8e0e2152504c473073360aac6b" "f527ccb8f7f1795d5ba0b63c8b696e358acc9f9692f683998579ab2278f7516e" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" "52f5a026cf8a9e457aeb3802c3e28fbd4ea3563001af6dfc4fd24635ae9b2581" "e7e6d8854450d371a984db0c81f6d34785e36a97df89bca99f7d1ccff4a11d9d" default))
 '(gpm-mouse-mode nil)
 '(highlight-indent-guides-auto-enabled nil)
 '(highlight-indent-guides-bitmap-function 'highlight-indent-guides--bitmap-line)
 '(highlight-indent-guides-method 'character)
 '(highlight-indent-guides-responsive 'top)
 '(package-selected-packages
   '(pdf-tools empv evil evil-visual-mark-mode hl-todo execline neotree highlight-indent-guides zig-mode yaml-mode bfbuilder rust-mode flycheck))
 '(standard-indent -1)
 '(warning-suppress-log-types
   '(((flycheck syntax-checker))
	 ((flycheck syntax-checker))
	 ((flycheck syntax-checker))
	 ((flycheck syntax-checker))))
 '(warning-suppress-types
   '(((flycheck syntax-checker))
	 ((flycheck syntax-checker))
	 ((flycheck syntax-checker))
	 ((flycheck syntax-checker))))
 '(xterm-mouse-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#000000" :foreground "#ebdbb2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "slavfox" :family "Cozette"))))
 '(line-number ((t (:foreground "#ff7090"))))
 '(line-number-current-line ((t (:foreground "#66ffbb"))))
 '(mode-line ((t (:box nil "#a0a0a0" :background "color-16" nil))))
 '(separator-line ((t (:foreground "#ff7090")))))

(global-hl-todo-mode +1)
(setq hl-todo-keyword-faces
      '(("TODO"   . "#FF0000")
        ("FIXME"  . "#FF0000")
        ("DEBUG"  . "#A020F0")
        ("GOTCHA" . "#FF4500")
        ("STUB"   . "#1E90FF")))

(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(defvaralias 'c-basic-offset 'tab-width) (setq ruby-indent-tabs-mode nil)
(defvaralias 'ruby-indent-level 'tab-width) (defvaralias 'sgml-basic-offset 'tab-width)
(defvaralias 'zig-indent-level 'tab-width)
(setq make-backup-files nil)
(setq backup-directory-alist
	  `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
	  `((".*" ,temporary-file-directory t)))
(global-display-line-numbers-mode)
(column-number-mode 1)
;;idk what is this seriously
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(global-prettify-symbols-mode 1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(add-hook 'after-init-hook #'global-flycheck-mode)
(mouse-wheel-mode t)
 ;;(menu-bar-mode -1) 
(global-set-key (kbd "M-o") (lambda () (interactive) (save-buffers-kill-terminal)))
(global-set-key (kbd "M-p") (lambda () (interactive) (menu-bar-mode)))
(global-set-key (kbd "M-n") (lambda () (interactive) (save-buffer)))
;; C-Like
(dolist (mode-iter '(c-mode c++-mode glsl-mode java-mode javascript-mode rust-mode))
  (font-lock-add-keywords
    mode-iter
    '(("\\([~^&\|!<>=,.\\+*/%-]\\)" 0 'font-lock-operator-face keep)))
  (font-lock-add-keywords
    mode-iter
    '(("\\([\]\[}{)(:;]\\)" 0 'font-lock-delimit-face keep)))
  ;; functions
  (font-lock-add-keywords
    mode-iter
    '(("\\([_a-zA-Z][_a-zA-Z0-9]*\\)\s*(" 1 'font-lock-function-name-face keep))))

;;????????????????????
;; credit: yorickvP on Github
  (setq wl-copy-process nil)
  (defun wl-copy (text)
    (setq wl-copy-process (make-process :name "wl-copy"
										:buffer nil
										:command '("wl-copy" "-f" "-n")
										:connection-type 'pipe))
    (process-send-string wl-copy-process text)
    (process-send-eof wl-copy-process))
  (defun wl-paste ()
    (if (and wl-copy-process (process-live-p wl-copy-process))
        nil ; should return nil if we're the current paste owner
        (shell-command-to-string "wl-paste -n | tr -d \r")))
  (setq interprogram-cut-function 'wl-copy)
  (setq interprogram-paste-function 'wl-paste)


(require 'bfbuilder)
(add-to-list 'auto-mode-alist '("\\.bf$" . bfbuilder-mode))
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(defun toggle-mode-line ()
  (interactive)
  (setq mode-line-format
    (if (equal mode-line-format nil)
        (default-value 'mode-line-format)) )
  (redraw-display))

(global-set-key [M-f12] 'toggle-mode-line)
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;(require 'package)
;(add-to-list 'package-archives
;             '("melpa" . "https://melpa.org/packages/"))
;(package-initialize)
;(package-refresh-contents)
;
;
;(unless (package-installed-p 'evil)
;  (package-install 'evil))

;(require 'evil)
;(evil-mode 1)
(add-to-list 'default-frame-alist '(font . "-slavfox-Cozette-normal-normal-normal-*-13-*-*-*-m-60-iso10646-1" ))
(set-face-attribute 'default t :font "-slavfox-Cozette-normal-normal-normal-*-13-*-*-*-m-60-iso10646-1" )
(set-face-attribute 'default nil :font "-slavfox-Cozette-normal-normal-normal-*-13-*-*-*-m-60-iso10646-1" )
(set-frame-font "-slavfox-Cozette-normal-normal-normal-*-13-*-*-*-m-60-iso10646-1" nil t)
(setq inhibit-startup-screen t)
(if (not (display-graphic-p))
    (set-face-background 'default "#ff000000"))

(require 'pdf-tools)
;(setq pdf-view-use-scaling nil)
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))

(add-hook 'pdf-view-mode-hook (lambda () (display-line-numbers-mode -1)))
