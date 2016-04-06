;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; basic emacs configuration to be used in conjunction with prelude       ;;
;;;;; pragmaticemacs.com/installing-and-setting-up-emacs/                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Add MELPA repository for packages
(add-to-list 'package-archives
            '("melpa" . "http://melpa.org/packages/") t)

(set-default-font "Inconsolata-16")

;;smooth scrolling
(setq prelude-use-smooth-scrolling t)

;; Don't wait for any other keys after escape is pressed.
(setq evil-esc-delay 1)

;; use the brew python version
(setq anaconda-mode-server-script
      "/usr/local/lib/python2.7/site-packages/anaconda_mode.py")

;; display options
(tool-bar-mode 1)
(menu-bar-mode 1)

;; Makes visible trailing whitespace
(setq show-trailing-whitespace t)

;; Auto-complete options
(global-company-mode t)
(setq company-tooltip-limit 12) ; bigger popup window
(setq company-idle-delay .1) ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0) ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
(setq company-dabbrev-downcase nil) ; Do not convert to lowercase
(setq company-selection-wrap-around t) ; continue from top when reaching bottom

;; Show listing of files vertically
(setq ido-decorations (quote ("\n↪ "     "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

;; better file matching
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)

;; Personalized keybindings
(define-key evil-motion-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-motion-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-motion-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-motion-state-map (kbd "C-l") 'evil-window-right)

;; Kill all buffers of a project
(define-key evil-motion-state-map (kbd "C-a") 'projectile-kill-buffers)

;; Custom split windows
(define-key evil-motion-state-map "-" 'evil-window-split)
(define-key evil-motion-state-map "|" 'evil-window-vsplit)

;; Configure leader key
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "." 'find-tag
  "t" 'projectile-find-file
  "p" 'projectile-switch-project
  "v" 'evil-window-vsplit
  "w" 'evil-window-split
  "z" 'neotree-toggle
  "gc" 'comment-or-uncomment-region
  "gg" 'indent-region
  "nn" 'untabify
  "ns" 'delete-trailing-whitespace
  "is" 'py-isort-buffer
  "bd" 'kill-this-buffer)

;; run isort before saving python files
(add-hook 'before-save-hook 'py-isort-before-save)

;; Commands to work in neotree
(add-hook 'neotree-mode-hook
 (lambda ()
   (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
   (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
   (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
   (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
   (define-key evil-normal-state-local-map (kbd "ma") 'neotree-create-node)
   (define-key evil-normal-state-local-map (kbd "md") 'neotree-delete-node)
   (define-key evil-normal-state-local-map (kbd "r") 'neotree-refresh)
   (define-key evil-normal-state-local-map (kbd "mm") 'neotree-rename-node)
))

;; Show the column number in the status bar
(column-number-mode t)

;; Show line-number in buffer
(add-hook 'prog-mode-hook 'linum-mode)
(setq linum-format "%4d ")

;; Activate theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)

;; Highlight cursor line
(global-hl-line-mode t)
(set-face-background hl-line-face "gray10")

;; Use 2 spaces in yaml files
(add-hook 'yaml-mode-hook (lambda ()
                            (setq evil-shift-width 2)
                            (setq tab-width 2)))

;; Spotify client configuration
(add-to-list 'load-path "~/development/spotify.el")
(require 'spotify)

(defun spotify-credentials-config-contents ()
  "Get contents of ~/.spotify-el file if it exists"
 (if (= (shell-command "stat ~/.spotify-el") 0)
   (shell-command-to-string "cat ~/.spotify-el")
   ""))

(defun spotify-credentials (key)
  "Get client secret from spotify credentials in ~/.spotify-el"
  (let ((credentials (spotify-credentials-config-contents)))
    (save-match-data
      (string-match (concat (concat "^" key) "=\\([^\s\n]+\\)") credentials)
      (match-string 1 credentials))))

(setq spotify-oauth2-client-id (spotify-credentials "client-id"))
(setq spotify-oauth2-client-secret (spotify-credentials "client-secret"))
