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
(global-set-key (kbd "s-l") 'goto-line)
