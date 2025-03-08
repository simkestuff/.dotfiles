(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

;;; Set up the package manager

(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(when (< emacs-major-version 29)
  (unless (package-installed-p 'use-package)
    (unless package-archive-contents
      (package-refresh-contents))
    (package-install 'use-package)))

(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

;;;; custom modules directory
(add-to-list 'load-path (expand-file-name "sk-modules/" user-emacs-directory))

;;; Don't litter file system with *~ backup files; put them all inside
;;; ~/.emacs.d/backup or wherever
(defun sk--backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let* ((backupRootDir (concat user-emacs-directory "emacs-backup/"))
         (filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath )) ; remove Windows driver letter in path
         (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~") )))
    (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
    backupFilePath))
(setopt make-backup-file-name-function 'sk--backup-file-name)

;;; Basic behaviour

(blink-cursor-mode -1)         ; Steady cursor
(pixel-scroll-precision-mode)  ; Smooth scrolling
(customize-set-variable 'inhibit-startup-message t)
(customize-set-variable 'initial-scratch-message "")
(customize-set-variable 'use-short-answers t)

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))


;;;; highlight current line
(global-hl-line-mode)
;;;; line is what is visible on screen
(global-visual-line-mode t)

;;;; relative line numbers 
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;;;; which-key
(use-package which-key
  :ensure nil
  :config
  (which-key-mode))

;;; Tweak the looks of Emacs

;;;; Fonts
;; opcije :
;; "JetBrainsMono Nerd Font Mono"
;; "CommitMono"
(let ((mono-spaced-font "Iosevka Nerd Font")
      (proportionately-spaced-font "Iosevka Nerd Font Propo"))
  (set-face-attribute 'default nil :family mono-spaced-font :height 130)
  (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.0))

;;;; Themes

(use-package modus-themes
  :ensure t
  :config
  (load-theme 'modus-operandi :no-confirm-loading))

(use-package gruber-darker-theme
  :ensure t)

(defun sk-switch-theme (theme)
  "Disable all themes and load the specified THEME."
  (interactive
   (list (intern (completing-read "Choose theme: " (mapcar #'symbol-name (custom-available-themes))))))
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme t))


;; Remember to do M-x and run `nerd-icons-install-fonts' to get the
;; font files.  Then restart Emacs to see the effect.
(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

;;; Configure the minibuffer and completions

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode))

(use-package marginalia
  :ensure t
  :hook (after-init . marginalia-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-ignore-case t)
  (setq completion-styles '(orderless basic partial-completion))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))


(use-package savehist
  :ensure nil ; it is built-in
  :hook (after-init . savehist-mode))

;;;; Consult
(use-package consult
  :ensure t
  :bind (
         ;; Drop-in replacements
         ("C-x b" . consult-buffer)     ; orig. switch-to-buffer
         ("M-y"   . consult-yank-pop)   ; orig. yank-pop
         ;; Searching
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)       ; Alternative: rebind C-s to use
         ("M-s s" . consult-line)       ; consult-line instead of isearch, bind
         ("M-s L" . consult-line-multi) ; isearch to M-s s
         ("M-s o" . consult-outline)
         ;; Isearch integration
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)   ; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history) ; orig. isearch-edit-string
         ("M-s l" . consult-line)            ; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)      ; needed by consult-line to detect isearch
         )
  :config
  ;; Narrowing lets you restrict results to certain groups of candidates
  (setq consult-narrow-key "<"))

;;; Completion at point
;;;; Corfu: Popup completion-at-point
(use-package corfu
  :ensure t
  :hook (after-init . global-corfu-mode)
  :bind (:map corfu-map
	      ("<tab>" . corfu-complete))
  :config
  (setq corfu-auto t)
  (setq tab-always-indent 'complete)
  (setq corfu-preview-current nil)
  (setq corfu-min-width 20)

  (setq corfu-popupinfo-delay '(0.25 . 0.5))
  (corfu-popupinfo-mode 1) ; shows documentation after `corfu-popupinfo-delay'

  ;; Sort by input history (no need to modify `corfu-sort-function').
  (with-eval-after-load 'savehist
    (corfu-history-mode 1)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

;;;;; Make corfu popup come up in terminal overlay
(use-package corfu-terminal
  :if (not (display-graphic-p))
  :ensure t
  :config
  (corfu-terminal-mode))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;;; The file manager (Dired)

(use-package dired
  :ensure nil
  :commands (dired)
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-dwim-target t))

(use-package dired-subtree
  :ensure t
  :after dired
  :bind
  ( :map dired-mode-map
    ("<tab>" . dired-subtree-toggle)
    ("TAB" . dired-subtree-toggle)
    ("<backtab>" . dired-subtree-remove)
    ("S-TAB" . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))

(use-package trashed
  :ensure t
  :commands (trashed)
  :config
  (setq trashed-action-confirmer 'y-or-n-p)
  (setq trashed-use-header-line t)
  (setq trashed-sort-key '("Date deleted" . t))
  (setq trashed-date-format "%Y-%m-%d %H:%M:%S"))

;;; Evil
(use-package evil
  :ensure t
  :init
  (customize-set-variable 'evil-want-integration t)
  (customize-set-variable 'evil-want-keybinding nil)
  (customize-set-variable 'evil-want-C-i-jump nil)
  (customize-set-variable 'evil-want-C-u-scroll t)
  (customize-set-variable 'evil-respect-visual-line-mode t)
  (customize-set-variable 'evil-want-C-h-delete t)
  (customize-set-variable 'evil-want-C-w-in-emacs-state t)
  :config
  (evil-mode 1)
  ;; modes that starts in emacs mode instead of normal mode
  (dolist (mode '(dired-mode
		  compilation-mode
		  ediff-mode
		  calendar-mode
		  Info-mode))
    (evil-set-initial-state mode 'emacs)))

;;;;; jj escape evil-insert-mode
(use-package key-chord
  :ensure t
  :config
  (setq key-chord-two-keys-delay 0.5)
  (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
  (key-chord-mode 1))
  

;;; Org
(use-package org
  :ensure nil
  :config
  (customize-set-variable 'org-directory "~/org")
  (customize-set-variable 'org-default-notes-file (concat org-directory "/notes.org"))
  (global-set-key (kbd "C-c L") #'org-store-link)
  (global-set-key (kbd "C-c a") #'org-agenda)
  (global-set-key (kbd "C-c c") #'org-capture)
  ;; org-id
  (require 'org-id)
  (setq org-id-link-to-org-use-id 'create-if-interactive)
  (customize-set-variable 'org-id-link-consider-parent-id t)
  ;; misc
  (customize-set-variable 'org-hide-leading-stars t) ; sakrij sve osim zadnjeg asteriksa
  (customize-set-variable 'org-startup-indented t) ; uvuci tekst i poravnaj ga prema headline-u
  (customize-set-variable 'org-image-actual-width nil) ; ne korisni stvarnu širinu slike
  (customize-set-variable 'org-return-follows-link t) ; RET će slijediti link
  (customize-set-variable 'org-log-into-drawer t)
  (customize-set-variable 'org-hide-emphasis-markers t)) ; sakriva oznake za bold, italics i slično

(use-package org-agenda
  :ensure nil
  :config
  (customize-set-variable 'org-agenda-files '("~/org/")))

(use-package org-capture
  :ensure nil
  :config
  (setq org-capture-templates
	'(("t" "Task" entry
	   (file+headline "" "Tasks")
	   "* TODO %?\n %U\n")
	  ("d" "Daily Notes")
	  ("dj" "Journal" entry
	   (file+headline (lambda() (sk-daily-today-file)) "Journal")
	   "** %?\nadded: %U\n" :empty-lines 1)
	  ("ds" "ScratchPad" plain
	   (file+headline (lambda() (sk-daily-today-file)) "ScratchPad")
	   "%?" :empty-lines 1)
	  )))


;;; lsp
(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (c-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :config
  (setq lsp-completion-provider :capf)
  (setq lsp-modeline-diagnostics-scope :workspace)
  (setq lsp-headerline-breadcrumb-enable nil)
  :commands lsp)

;;;; lsp tuning
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;;;;; clang-format on save
(use-package clang-format
  :ensure t
  :config
  (setq clang-format-style "file"))

(defun sk-c-mode-hook ()
  (add-hook 'before-save-hook #'clang-format-buffer nil t))

(add-hook 'c-mode-hook #'sk-c-mode-hook)

(setq c-default-style '((java-mode . "java") (awk-mode . "awk") (c-mode . "stroustrup") (other . "gnu")))


;;;; Magit
(use-package magit
  :ensure t)
(put 'upcase-region 'disabled nil)


;;;; Custom
(require 'sk-daily)
(define-key global-map (kbd "M-n") #'sk-daily-today)
