;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; This is where you install packages, by declaring them with the `package!'
;; macro, then running 'doom refresh' on the command line. You'll need to
;; restart Emacs for your changes to take effect! Or at least, run M-x
;; `doom/reload'.
;;
;; WARNING: Don't disable core packages listed in ~/.emacs.d/core/packages.el.
;; Doom requires these, and disabling them may have terrible side effects.
;;
;; Here are a couple examples:

;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a particular repo, you'll need to specify
;; a `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, for whatever reason,
;; you can do so here with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Filestuff
(package! ranger)
(package! flycheck)
(package! org-super-agenda)
(package! real-auto-save)
(package! winum)
(package! treemacs)
(package! lsp-treemacs)
(package! treemacs-evil)
(package! treemacs-magit)
(package! treemacs-projectile)
(package! treemacs-icons-dired)

;; Misc stuff
;; Can highlight a region and hit M-x carbon-now-sh to get a
;; https://carbon.now.sh of the region
(package! carbon-now-sh)
(package! yasnippet)
(package! emmet-mode)

;; Email stuff
(package! notmuch)
(if (featurep! :completion ivy)
    (package! counsel-notmuch)
  (package! helm-notmuch))
(package! org-mime)

;; golden ratio stuff
(package! golden-ratio)
(package! golden-ratio-scroll-screen)

;; lsp stuff
(package! lsp-ui)
(package! lsp-treemacs)
(package! lsp-java)
(package! lsp-ivy)

;; web stuff
(package! web-mode)
(package! web-mode-edit-element)

;;js-stuff
(package! js-doc)
(package! prettier-js)
(package! requirejs-mode)
(package! js-import)
(package! js-format)
(package! js-react-redux-yasnippets)
(package! pkgbuild-mode)
(package! eslint-fix)
(package! eslintd-fix)
(package! flymake-eslint)

;; go related stuff
(package! go-mode)
(package! flymake-go)
(package! flymake-golangci)
(package! flycheck-golangci-lint)
(package! go-imenu)
(package! go-guru)
(package! go-impl)
(package! go-imports)
(package! go-projectile)
(package! go-rename)
(package! golint)
(package! go-gopath)
(package! go-errcheck)
(package! go-eldoc)
(package! go-dlv)
(package! go-direx)
(package! go-complete)
(package! go-add-tags)
(package! go-scratch)
(package! go-snippets)
(package! go-stacktracer)
(package! go-tag)
(package! go-playground)
(package! go-playground-cli)
(package! go-gen-test)

;; typescript stuff
(package! typescript-mode)
(package! tide)
(package! ob-typescript)

;;
;; Ruby stuff
(package! enh-ruby-mode)
(package! rbenv) ;; i use rbenv
(package! yard-mode)
(package! rinari)
(package! rubocop)
