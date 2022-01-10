(setq inhibit-startup-message t) ;Inhibit the starting message
(scroll-bar-mode -1) ; Visible scroll bar
(tool-bar-mode -1) ; Disable tool bar
(tooltip-mode -1)  ; Disable tooltips
(set-fringe-mode 10) ;Giving some breathing room

(menu-bar-mode -1) ; Disable menu bar

(setq visible-bell t); Set up visible bell

(set-face-attribute 'default nil :font "consolas" :height 120); Customizing the font of the editor

(load-theme 'doom-gruvbox)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

					; Initializes Packages resources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package command-log-mode)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))


(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsexl-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

;; DOOM MODE AND THEMES

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode))



(setq doom-modeline-height 12)
(setq doom-modeline-bar-width 10)
(setq doom-modeline-height 1)
(set-face-attribute 'mode-line nil :family "consolas" :height 100)
(set-face-attribute 'mode-line-inactive nil :family "consolas" :height 100)


;; Doom Themes
(use-package doom-themes)


;; Line Numbers in the Buffer
;; Turn ON line numbers in the buffers

(column-number-mode)
(global-display-line-numbers-mode t)

;; Disabling line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		treemacs-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Rainbow delimiter config

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; WHICH KEY config
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; Configuring Ivy Rich Mode this describe the commands
(use-package ivy-rich
  :init (ivy-rich-mode 1))

;; LSP mode experimental configuration
(use-package lsp-mode
  :hook (prog-mode . lsp))

(use-package lsp-ui)

;; (use-package lsp-python-ms
;;   :after lsp
;;   :ensure t
;;   :defer 0.3
;;   ;;:custom (lsp-python-ms-auto-install-server t)
;;   :hook (python-mode . (lambda ()
;; 			 (require 'lsp-python-ms)
;; 			 (lsp)))
;;   :init
;;   (setq lsp-python-ms-executable
;; 	"/home/devcrack/Documents/Repositories/python-language-server/output/bin/Release/linux-x64/publish/Microsoft.Python.LanguageServer"))

(use-package lsp-python-ms
  :defer 0.3
  :custom (lsp-python-ms-auto-install-server t))


(use-package python
  :delight "π "
  :bind (("M-[" . python-nav-backward-block)
         ("M-]" . python-nav-forward-block))
  :preface
  (defun python-remove-unused-imports()
    "Removes unused imports and unused variables with autoflake."
    (interactive)
    (if (executable-find "autoflake")
        (progn
          (shell-command (format "autoflake --remove-all-unused-imports -i %s"
                                 (shell-quote-argument (buffer-file-name))))
          (revert-buffer t t t))
      (warn "python-mode: Cannot find autoflake executable."))))
