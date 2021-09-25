;; Check if system is Darwin/macOS
(defun is-macos ()
  "Return true if system is darwin-based (Mac OS X)"
  (string-equal system-type "darwin"))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
;; makes sure the contents of the buffer is refreshed automatically when the file is changed outside of Emacs
(global-auto-revert-mode t)
(load-theme 'tsdh-light)

;; disable auto save and backups
(setq auto-save-default nil)
(setq make-backup-files nil)

;; Move file to trash instead of removing.
(setq-default delete-by-moving-to-trash t)

;; C - Control
;; Super - Command
;; Meta - Option
(when (is-macos)
  (setq
   mac-right-command-modifier 'super
   mac-command-modifier 'super
   mac-option-modifier 'meta
   mac-left-option-modifier 'meta
   mac-right-option-modifier 'meta
   ;;mac-right-option-modifier 'nil
   ))

(global-set-key (kbd "C-s-f") 'toggle-frame-fullscreen)

(global-set-key (kbd "s-=") 'text-scale-increase)
(global-set-key (kbd "s--") 'text-scale-decrease)


(setq
 inhibit-startup-message t         ; Don't show the startup message
 inhibit-startup-screen t          ; or screen
)

(global-set-key (kbd "s-<right>") 'end-of-visual-line)
(global-set-key (kbd "s-<left>") 'beginning-of-visual-line)
(global-set-key (kbd "s-<up>") 'beginning-of-buffer)
(global-set-key (kbd "s-<down>") 'end-of-buffer)
(global-set-key (kbd "M-<down>") 'forward-sentence)
(global-set-key (kbd "M-<up>") 'backward-sentence)
(global-set-key (kbd "s-l") 'goto-line)


(global-set-key (kbd "M-n") 'backward-sexp)
(global-set-key (kbd "M-i") 'forward-sexp)

;; Many commands in Emacs write the current position into mark ring.
;; These custom functions allow for quick movement backward and forward.
;; For example, if you were editing line 6, then did a search with Cmd+f, did something and want to come back,
;; press Cmd+, to go back to line 6. Cmd+. to go forward.
;; These keys are chosen because they are the same buttons as < and >, think of them as arrows.
(defun my-pop-local-mark-ring ()
  (interactive)
  (set-mark-command t))

(defun unpop-to-mark-command ()
  "Unpop off mark ring. Does nothing if mark ring is empty."
  (interactive)
      (when mark-ring
        (setq mark-ring (cons (copy-marker (mark-marker)) mark-ring))
        (set-marker (mark-marker) (car (last mark-ring)) (current-buffer))
        (when (null (mark t)) (ding))
        (setq mark-ring (nbutlast mark-ring))
        (goto-char (marker-position (car (last mark-ring))))))

(global-set-key (kbd "s-,") 'my-pop-local-mark-ring)
(global-set-key (kbd "s-.") 'unpop-to-mark-command)

;; Same keys with Shift will move you back and forward between open buffers.
(global-set-key (kbd "s-<") 'previous-buffer)
(global-set-key (kbd "s->") 'next-buffer)

;; ============
;; TEXT EDITING

;; Comment line or region.
(global-set-key (kbd "s-/") 'comment-line)


;; =================
;; WINDOW MANAGEMENT

;; Go to other windows easily with Cmd
(global-set-key (kbd "s-1") (kbd "C-x 1"))  ;; Cmd-1 kill other windows (keep 1)
(global-set-key (kbd "s-2") (kbd "C-x 2"))  ;; Cmd-2 split horizontally
(global-set-key (kbd "s-3") (kbd "C-x 3"))  ;; Cmd-3 split vertically
(global-set-key (kbd "s-0") (kbd "C-x 0"))  ;; Cmd-0...
(global-set-key (kbd "s-w") (kbd "C-x 0"))  ;; ...and Cmd-w to close current window

;;other window
(global-set-key (kbd "M-o") 'other-window)

;; =================
;; Package makagement
(when window-system
  (message "i am in GUI")
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "https://melpa.org/packages/")
   t)

  (package-initialize)


  ;;'use-package' to install and configure packages.
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (eval-when-compile (require 'use-package))

  ;; For learning Emacs, shows a table of possible commands.
  (use-package which-key
    :ensure t
    :init
    (which-key-mode))

  ;; Move between windows with Control-Command-Arrow and with =Cmd= just like in iTerm.
  (use-package windmove
    :config
    (global-set-key (kbd "<C-s-left>")  'windmove-left)  ;; Ctrl+Cmd+left go to left window
    (global-set-key (kbd "s-[")  'windmove-left)         ;; Cmd+[ go to left window

    (global-set-key (kbd "<C-s-right>") 'windmove-right) ;; Ctrl+Cmd+right go to right window
    (global-set-key (kbd "s-]")  'windmove-right)        ;; Cmd+] go to right window

    (global-set-key (kbd "<C-s-up>")    'windmove-up)    ;; Ctrl+Cmd+up go to upper window
    (global-set-key (kbd "s-{")  'windmove-up)           ;; Cmd+Shift+[ go to upper window

    (global-set-key (kbd "<C-s-down>")  'windmove-down)  ;; Ctrl+Cmd+down go to down window
    (global-set-key (kbd "s-}")  'windmove-down))        ;; Cmd+Shift+] got to down window

  (use-package doom-modeline
    :ensure t
    :init (doom-modeline-mode 1))

  (setq doom-modeline-buffer-encoding t)
  (setq doom-modeline-indent-info t)
  )

;; Store custom-file separately, don't freak out when it's not found.
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)
