;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Henrique Rocha"
      user-mail-address "henriquerocha@tutanota.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "D2 Coding" :size 18 :weight 'Regular)
      doom-variable-pitch-font (font-spec :family "D2 Coding" :size 17)
 doom-big-font (font-spec :family "D2 Coding" :size 30))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)
(setq doom-gruvbox-dark-variant t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Set hard tabs on C and C++ files
(setq-hook! '(c-mode-hook c++-mode-hook) indent-tabs-mode t)

;; Set ZSH on terminals
(setq shell-file-name "/bin/zsh"
      vterm-max-scrollback 5000)

;; Prevent flickering
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;; Switch to the new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Banner
;; (setq! +doom-dashboard-functions '(
;;         doom-dashboard-widget-banner
;;         doom-dashboard-widget-footer))
(custom-set-faces!
  '(doom-dashboard-banner :weight regular)) ;; Fixing the DOOM ASCII

;; Bookmarks
(map! :leader
      (:prefix ("b". "buffer")
       :desc "List bookmarks" "L" #'list-bookmarks
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save))

;; Eval
(map! :leader
      (:prefix ("e". "evaluate")
       :desc "Evaluate elisp in buffer" "e" #'eros-eval-last-sexp))

;; Elcord
(elcord-mode)
(custom-set-variables
;; '(elcord-editor-icon "emacs_icon")
'(elcord-use-major-mode-as-main-icon t))
;; '(elcord-show-small-icon nil))

;; Crystal
(use-package! lsp-mode
    :commands lsp
    :ensure t
    :diminish lsp-mode
    :hook
    (crystal-mode . lsp)
    :init
    (add-to-list 'exec-path "/home/rike/.emacs.d/crystal-ls"))

;; Kotlin
(use-package! lsp-mode
    :commands lsp
    :ensure t
    :diminish lsp-mode
    :hook
    (kotlin-mode . lsp)
    :init
    (add-to-list 'exec-path "/home/rike/.emacs.d/kotlin-ls/kotlin-language-server/install/server/bin"))

;; Debugger
(setq! realgud-short-key-mode nil)

;; Treemacs
(after! projectile (setq projectile-project-root-files-bottom-up
                         (remove ".git" projectile-project-root-files-bottom-up)))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
