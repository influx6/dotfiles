;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.

;; (require 'timestamp "timestamp")

(setq user-full-name "Alexander Ewetumo"
      user-mail-address "trinoxf@gmail.com")

(fset 'battery-update #'ignore)

(setq explicit-shell-file-name "/bin/bash")

(defun my/term ()
  "My personal term command."
  (interactive)
  (set-buffer (make-term "terminal" explicit-shell-file-name projectile-project-root))
  (term-mode)
  (term-char-mode)
  (switch-to-buffer "*terminal*"))
(map! (:leader
        (:desc "open shell" :g "oe" #'my/term)) ;; 这个快捷键是SPC o e
)

;; Load snippets
(after! yasnippet
  (push (expand-file-name "snippets/" doom-private-dir) yas-snippet-dirs))

(after! typescript-mode
  (add-hook 'typescript-mode-hook #'flycheck-mode)
  (setq typescript-indent-level 2))

(setq js-indent-level 2
      js2-basic-offset 2)

(setq +set-eslint-checker nil)

;; lsp
(after! lsp-ui
  ;; for whatever reason, this was running twice.
  (setq lsp-ui-sideline-show-hover t)
  (when (not +set-eslint-checker)
    (progn
      (setq +set-eslint-checker t)
      (flycheck-add-mode 'javascript-eslint 'web-mode)
      (flycheck-add-next-checker 'lsp-ui '(warning . javascript-eslint)))))

;; web mode
(after! web-mode
  (add-hook 'web-mode-hook #'flycheck-mode)

  (setq web-mode-markup-indent-offset 2 ;; Indentation
        web-mode-code-indent-offset 2
        web-mode-enable-auto-quoting nil ;; disbale adding "" after an =
        web-mode-auto-close-style 2))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; test
(setq doom-font (font-spec :family "monospace" :size 14)
      doom-variable-pitch-font (font-spec :family "Open Sans"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(def-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-super-agenda-groups '((:name "Today"
                                         :time-grid t
                                         :scheduled tod)
                                  (:name "Due today"
                                         :deadline today)
                                  (:name "Important"
                                         :priority "A")
                                  (:name "Overdue"
                                         :deadline past)
                                  (:name "Due soon"
                                         :deadline future)
                                  (:name "Big Outcomes"
                                         :tag "bo")
                                  ))
  :config
  (org-super-agenda-mode)
  )
(setq display-line-numbers-type 'relative)

(setq doom-theme 'doom-nord)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)
;; (setq doom (toggle-line-numbers-type t))

  ;; (add-hook 'prog-mode-hook 'real-auto-save-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
;; (setq real-auto-save-interval 1) ;; in seconds
;; (add-hook 'prog-mode-hook 'real-auto-save-mode)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(winum-mode)

(map! (:leader
        (:desc "Select dir-tree window" :g "0" #'treemacs-select-window))
)
(map! :leader
  "1" 'winum-select-window-1
  "2" 'winum-select-window-2
  "3" 'winum-select-window-3
  "4" 'winum-select-window-4            ;
  "5" 'winum-select-window-5
  "6" 'winum-select-window-6
  "7" 'winum-select-window-7
  "8" 'winum-select-window-8
  "9" 'winum-select-window-9
  )

(setq make-backup-files nil)


;; buffer search customization
(map! (:leader
     (:desc "buffer find" :g "bf" nil)))

(map! (:leader
        (:desc "search buffer line" :g "bf1" #'counsel-grep-or-swiper)))

(map! (:leader
        (:desc "search buffer snipe" :g "bf2" #'avy-goto-char-2)))

(map! (:leader
        (:desc "search buffer project" :g "bfp" #'counsel-git-grep)))

;; indentation customation
(map! (:leader
        (:desc "indent-relative" :g "ir" #'indent-relative)))

;; ein treemacs customization
(map! (:leader
        (:desc "Treemacs" :g "z" #'treemacs)))

;; ein Jupiter customization
(map! (:leader
        (:desc "Jupyter" :g "J" nil)))

(map! (:leader
        (:desc "run" :g "Jr" #'ein:run)))

(map! (:leader
        (:desc "login" :g "Jl" #'ein:login)))

;; ein customization
(map! (:leader
        (:desc "open file" :g "Jf" #'ein:connect-to-notebook)))

(map! (:leader
        (:desc "go to next cell" :g "Jn" #'ein:worksheet-goto-next-input)))

(map! (:leader
        (:desc "go to prev cell" :g "Jp" #'ein:worksheet-goto-prev-input)))

(map! (:leader
        (:desc "execute" :g "Je" nil)))

(map! (:leader
        (:desc "execute cell and go to next" :g "Jec" #'ein:worksheet-execute-cell-and-goto-next)))

(map! (:leader
        (:desc "execute cell" :g "JeC" #'ein:worksheet-execute-cell)))


(defun displaymode ()
  (interactive)
  (print major-mode)
  )

(map! (:leader
        (:desc "mode" :g "M" nil)))

(map! (:leader
        (:desc "Major mode" :g "Mm" #'displaymode)))

;; evil customizatioN
(evil-define-motion evil-jzz (count)
  "j to jzz"
  :type line
  (evil-next-line (or count 1))
  (evil-scroll-line-to-center nil))
(define-key evil-normal-state-map (kbd "j") 'evil-jzz)

(evil-define-motion evil-kzz (count)
  "j to kzz"
  :type line
  (evil-previous-line (or count 1))
  (evil-scroll-line-to-center nil))
(define-key evil-normal-state-map (kbd "k") 'evil-kzz)

;; enable whitespace minor mode after major mode of emacs-list-mode
;; (add-hook 'emacs-lisp-mode-hook 'whitespace-mode)
(global-whitespace-mode)

(progn
 ;; Make whitespace-mode with very basic background coloring for whitespaces.
  ;; http://ergoemacs.org/emacs/whitespace-mode.html
  (setq whitespace-style (quote (face spaces tabs newline space-mark tab-mark newline-mark )))

  ;; Make whitespace-mode and whitespace-newline-mode use “¶” for end of line char and “▷” for tab.
  (setq whitespace-display-mappings
        ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
        '(
          (space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
          (newline-mark 10 [9166 10]) ; LINE FEED,
          (tab-mark 9 [9655 9] [92 9]) ; tab
          )))

(setq-default evil-shift-width 2 ;; I normally use 2wide for my projects.
              tab-width 2)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
(load! "./typescript")
(load! "./assoc")
