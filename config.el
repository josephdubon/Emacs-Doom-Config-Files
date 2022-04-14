;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Joseph Dubon"
      user-mail-address "josephdubon@pm.me")

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
(setq doom-font (font-spec :family "Iosevka" :size 16 :weight 'light)
      doom-variable-pitch-font (font-spec :family "SF Pro" :size 14))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

  ; or for treemacs users
 (setq doom-themes-treemacs-theme "doom-colors") ; use "doom-colors" for less minimal icon theme

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

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

; Custom Org markers
(setq
 org-superstar-headline-bullets-list '("♔" "♕" "♗" "♘" "♙"))

;; Org indicators.
(setq org-refile-targets '((nil :maxlevel . 9)
(org-agenda-files :maxlevel . 9)))
(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling
(setq org-refile-allow-creating-parent-nodes (quote confirm))
(setq org-pretty-entities t)
(setq org-hide-emphasis-markers t)
(setq org-fontify-whole-heading-line t)
(setq org-fontify-done-headline t)
(setq org-fontify-quote-and-verse-blocks t)
(setq org-tags-column 0)
(setq org-src-fontify-natively t)
(setq org-edit-src-content-indentation 0)
(setq org-src-tab-acts-natively t)
(setq org-src-preserve-indentation t)
(setq org-log-done 'time)

;; Configure attachments to be stored together with their Org document.
(setq org-attach-id-dir "attachments/")

;; Org-Journal Settings
(setq org-journal-dir "~/org/journal/")
(setq org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org"
      )

;; Org-mode custom config
(after! org (setq org-hide-emphasis-markers t))

;; Enable logging of done tasks, and log stuff into the LOGBOOK drawer by default
(after! org
  (setq org-log-done t)
  (setq org-log-into-drawer t))

(use-package! org-agenda
  :defer t
  :init

  (setq org-agenda-files '("~/org/" "~/org/roam/" "~/org/roam/daily" "~/org/journal/"))

  :config
  ;; Custom time display
  (setq org-agenda-time-grid
        (quote
         ((daily today remove-match)
          (0500, 0600, 0700 0800 0900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100 2200 2300)
          "......" "------------")))

  ;; Custom keywords loop
  (setq org-todo-keywords '((sequence
                             "IN_MY_MIND"
                             "TODO"
                             "DOING"
                             "NEXT(n)"
                             "WAIT"
                             "HOLD"
                             "SOMEDAY"
                             "|"
                             "DONE(d@)"
                             "CANCEL(c@)")
                            (sequence
                             "MEETING"
                             "MEETING DONE(@)")
                            (sequence
                             "IDEA"
                             "GOAL"
                             "|"
                             "DUD(@)")
                            (sequence
                             "READ"
                             "READING"
                             "|"
                             "DROPPED"
                             "FINISHED")))
)

;; Cool agenda View
(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-block-separator nil
      org-agenda-compact-blocks t
      org-agenda-start-day nil ;; i.e. today
      org-agenda-span 1
      org-agenda-start-on-weekday nil)
  (setq org-agenda-custom-commands
        '(("c" "Super view"
           ((agenda "" ((org-agenda-overriding-header "")
                        (org-super-agenda-groups
                         '((:name "Today"
                                  :time-grid t
                                  :date today
                                  :order 1)))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:log t)
                            (:name "Overdue"
                                   :deadline past)
                            (:name "Due Today"
                                   :deadline today)
                            (:name "Doing"
                             :todo "DOING")
                            (:name "Next"
                             :todo "NEXT")
                            (:name "Master Inbox"
                             :todo "TODO")
                            (:name "Tasks That Need Filing"
                             :todo "IN_MY_MIND")
                            (:name "Important"
                                   :priority "A")
                            (:name "Today's tasks"
                                   :file-path "~/org/roam/daily")
                            (:name "Scheduled Soon"
                                   :scheduled future)
                            (:name "Meetings"
                             :and (:todo "MEETING" :scheduled future)
                             :scheduled today
                             )
                            (:name "Waiting or On Hold"
                             :todo "WAIT"
                             :and (:todo "HOLD"))
                            (:discard (:not (:todo "TODO")))))))))))
  :config
  (org-super-agenda-mode))


;; For some reason Doom disables auto-save and backup files by default.
;; Let’s reenable them.
(setq auto-save-default t
      make-backup-files t)

;; Enable showing a word count in the modeline.
;; This is only shown for the modes listed in
;; doom-modeline-continuous-word-count-modes
;; (Markdown, GFM and Org by default).
(setq doom-modeline-enable-word-count t)

;; Waka-time config
(use-package! wakatime-mode)

;; If you want to enable wakatime in all buffers
;; put at end of file
(global-wakatime-mode)
