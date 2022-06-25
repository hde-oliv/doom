;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Henrique Rocha"
      user-mail-address "henriquerocha@tutanota.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "monospace" :size 15 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "monospace" :size 14))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

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

(add-to-list 'default-frame-alist '(alpha-background  . 90))

;; Banner
(custom-set-faces!
  '(doom-dashboard-banner :weight regular)) ;; Fixing the DOOM ASCII

;; Elcord
(elcord-mode)
(custom-set-variables
;; '(elcord-editor-icon "emacs_icon")
'(elcord-use-major-mode-as-main-icon t))
;; '(elcord-show-small-icon nil))

;; Bookmarks
(map! :leader
      (:prefix ("b". "buffer")
       :desc "List bookmarks" "L" #'list-bookmarks
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save))

;; Eval
(map! :leader
      (:prefix ("e". "evaluate")
       :desc "Evaluate elisp in buffer" "e" #'eros-eval-last-sexp))

;; Debugger
(setq! realgud-short-key-mode nil)

;; Treemacs
(after! projectile (setq projectile-project-root-files-bottom-up
                         (remove ".git" projectile-project-root-files-bottom-up)))
(setq doom-themes-treemacs-theme "doom-colors")

;; Fringe
(setq fringe-mode 'minimal)

;; Modeline
(setq! doom-modeline-height 30)
(setq! doom-modeline-buffer-file-name-style 'truncate-except-project)
;; (setq! doom-modeline-major-mode-icon t)
(setq! doom-modeline-indent-info t)

;; Garbage Collection
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

(setq comp-async-report-warnings-errors nil)
(setq gc-cons-threshold (* 2 1000 1000))

(setq +format-on-save-enabled-modes
      '(not emacs-lisp-mode  ; elisp's mechanisms are good enough
            sql-mode         ; sqlformat is currently broken
            tex-mode         ; latexindent is broken
            c-mode
            latex-mode))

(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode t)

;; Set hard tabs on C and C++ files
(setq-hook! '(c++-mode-hook) indent-tabs-mode t
            c-basic-offset 4
            tab-width 4
	    backward-delete-function nil
            c-default-style "user"
	    )

(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-hungry-state 1)))

;; accept completion from copilot and fallback to company
(defun my-tab ()
  (interactive)
  (or (copilot-accept-completion)
      (company-indent-or-complete-common nil)))

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map company-active-map
         ("<tab>" . 'my-tab)
         ("TAB" . 'my-tab)
         :map company-mode-map
         ("<tab>" . 'my-tab)
         ("TAB" . 'my-tab)))

;; (use-package! lsp-mode
;;     :commands lsp
;;     :diminish lsp-mode
;;     :hook
;;     (go-mode . lsp)
;;     :init
;;     (add-to-list 'exec-path "/home/rike/.local/share/go/bin"))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
