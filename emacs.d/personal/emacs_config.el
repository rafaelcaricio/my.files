;; Where to get the packages
(add-to-list 'package-archives
            '("melpa" . "http://melpa.org/packages/") t)
(package-refresh-contents)

;; firulas
(setq frame-title-format '("🔮 Emacs"))

;; font configurations
(set-frame-font "Inconsolata for Powerline")
(set-face-attribute 'default nil :height 180)

;; smooth scrolling
(setq prelude-use-smooth-scrolling t)

;; Don't wait for any other keys after escape is pressed
(setq evil-esc-delay 1)

;; a little longer line length allowed
(setq whitespace-line-column 120)

;; remove scroll bar
(toggle-scroll-bar -1)
(menu-bar-mode -1)

;; use the brew python version
(setq anaconda-mode-server-script
      (expand-file-name "~/.pyenv/versions/3.5.1/lib/python3.5/site-packages/anaconda_mode.py"))

(defun run-python-once ()
  "Helper function to call 'run-python' only once."
  (remove-hook 'python-mode-hook 'run-python-once)
  (run-python))

(add-hook 'python-mode-hook 'run-python-once)
(setq python-shell-interpreter "~/.pyenv/shims/ipython3")

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

;; Show listing of files vertically ↪
(setq ido-decorations (quote ("\n👾 "     "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

;; better file matching
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)

;; Personalized keybindings
(define-key evil-motion-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-motion-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-motion-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-motion-state-map (kbd "C-l") 'evil-window-right)

;; Window resize
(define-key evil-motion-state-map (kbd "C->") 'enlarge-window-horizontally)
(define-key evil-motion-state-map (kbd "C-(") 'enlarge-window)
(define-key evil-motion-state-map (kbd "C-<") 'shrink-window-horizontally)
(define-key evil-motion-state-map (kbd "C-)") 'shrink-window)

;; Kill all buffers of a project
(define-key evil-motion-state-map (kbd "C-a") 'projectile-kill-buffers)

;; Configure leader key
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "." 'find-tag
  "t" 'projectile-find-file
  "p" 'projectile-switch-project
  "w" 'evil-window-vsplit
  "v" 'evil-window-split
  "z" 'neotree-toggle
  "U" 'upcase-region
  "u" 'downcase-region
  "gc" 'comment-or-uncomment-region
  "gg" 'indent-region
  "nn" 'untabify
  "ns" 'delete-trailing-whitespace
  "is" 'py-isort-buffer
  "bd" 'kill-this-buffer
  "sp" 'spotify-toggle-play
  "sf" 'spotify-next-track
  "sb" 'spotify-previous-track
  "sr" 'spotify-toggle-shuffle
  "cc" 'recenter
  "rn" 'iedit-mode)

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
   (define-key evil-normal-state-local-map (kbd "sr") 'neotree-change-root)
   (define-key evil-normal-state-local-map (kbd "mm") 'neotree-rename-node)
))
(setq neo-hidden-regexp-list '(;;"^\\."
                                "\\.pyc$"
                                ;;"~$"
                                "^.*.egg-info"
                                "^\\(build\\|dist\\)$"
                                "^\.\\(eggs\\|git\\|tox\\|cache\\)$"
                                "^#.*#$"
                                "\\.elc$"
                                "^__pycache__$"))

;; Show the column number in the status bar
(column-number-mode t)

;; Show line-number in buffer
(add-hook 'prog-mode-hook 'linum-mode)
(setq linum-format "%4d")

;; Use 2 spaces in yaml files
(add-hook 'yaml-mode-hook (lambda ()
                            (setq evil-shift-width 2)
                            (setq tab-width 2)))

;; Use 2 spaces in json files
(add-hook 'json-mode-hook (lambda ()
                            (setq evil-shift-width 2)
                            (setq tab-width 2)))

;; Use snippets everywhere
(require 'yasnippet)
(yas-global-mode 1)

;; Spotify client configuration
(add-to-list 'load-path "~/development/spotify.el")
(require 'spotify)
(defconst spotify-config-file ".spotify-el")

(defun spotify-credentials-config-contents ()
  "Get contents of ~/.spotify-el file if it exists"
  (if (= (shell-command (concat "stat ~/" spotify-config-file)) 0)
    (shell-command-to-string (concat "cat ~/" spotify-config-file))
    ""))

(defun spotify-credentials (key)
  "Get client secret from spotify credentials in ~/.spotify-el"
  (let ((credentials (spotify-credentials-config-contents)))
    (save-match-data
      (string-match (concat (concat "^" key) "=\\([^\s\n]+\\)") credentials)
      (match-string 1 credentials))))

(setq spotify-oauth2-client-id (spotify-credentials "client-id"))
(setq spotify-oauth2-client-secret (spotify-credentials "client-secret"))

;; Disable flycheck for elisp
(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

;; remove useless tool bar
(tool-bar-mode -1)

(remove-hook 'after-init-hook #'sml/setup)

;; Powerline settings
;(setq powerline-default-separator 'curve)
(setq powerline-default-separator 'wave)
;(setq powerline-default-separator 'butt)
(setq powerline-height 20)

;; Current theme
(load-theme 'spacemacs-dark)

;; Line configuration
(require 'spaceline-config)
(spaceline-spacemacs-theme)
(spaceline-toggle-buffer-encoding-off)
(spaceline-toggle-minor-modes-off)
(spaceline-toggle-buffer-encoding-abbrev-off)
(spaceline-toggle-window-number-off)
(spaceline-toggle-buffer-size-off)
(spaceline-toggle-remote-host-off)
(spaceline-toggle-buffer-encoding-abbrev-off)
(spaceline-toggle-buffer-position-off)
(spaceline-toggle-which-function-off)

;; fix bronke separator colors
(setq ns-use-srgb-colorspace nil)

;; Start in full screen mode
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

(nyan-mode 1)
(nyan-start-animation)

(provide 'emacs_config)
