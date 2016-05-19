;;; Uncomment the modules you'd like to use and restart Prelude afterwards

;;; Code:
;; (require 'prelude-erc)
(require 'prelude-ido) ;; Super charges Emacs completion for C-x C-f and more
;; (require 'prelude-helm) ;; Interface for narrowing and search
;; (require 'prelude-helm-everywhere) ;; Enable Helm everywhere
(require 'prelude-company)
;; (require 'prelude-key-chord) ;; Binds useful features to key combinations
;; (require 'prelude-mediawiki)
(require 'prelude-evil)

;;; Programming languages support
(require 'prelude-c)
(require 'prelude-clojure)
;; (require 'prelude-coffee)
(require 'prelude-common-lisp)
(require 'prelude-css)
(require 'prelude-emacs-lisp)
;; (require 'prelude-erlang)
;; (require 'prelude-elixir)
;; (require 'prelude-go)
;; (require 'prelude-haskell)
(require 'prelude-js)
;; (require 'prelude-latex)
(require 'prelude-lisp)
;; (require 'prelude-ocaml)
(require 'prelude-org) ;; Org-mode helps you keep TODO lists, notes and more
(require 'prelude-perl)
(require 'prelude-python)
;; (require 'prelude-ruby)
;; (require 'prelude-scala)
(require 'prelude-scheme)
(require 'prelude-shell)
;; (require 'prelude-scss)
(require 'prelude-web) ;; Emacs mode for web templates
(require 'prelude-xml)
(require 'prelude-yaml)

(unless (package-installed-p 'evil-leader)
  (package-install 'evil-leader))
(unless (package-installed-p 'neotree)
  (package-install 'neotree))
(unless (package-installed-p 'flx-ido)
  (package-install 'flx-ido))
(unless (package-installed-p 'dracula-theme)
  (package-install 'dracula-theme))
(unless (package-installed-p 'mmm-mode)
  (package-install 'mmm-mode))
(unless (package-installed-p 'markdown-mode)
  (package-install 'markdown-mode))
(unless (package-installed-p 'dockerfile-mode)
  (package-install 'dockerfile-mode))
(unless (package-installed-p 'py-isort)
  (package-install 'py-isort))
(unless (package-installed-p 'spacemacs-theme)
  (package-install 'spacemacs-theme))
(unless (package-installed-p 'spaceline)
  (package-install 'spaceline))
(unless (package-installed-p 'nyan-mode)
  (package-install 'nyan-mode))
(unless (package-installed-p 'yasnippet)
  (package-install 'yasnippet))
