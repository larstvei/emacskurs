;; Requiring features is like loading libraries.
;; We need these two in the config:
(require 'cl)
(require 'package)

;; add mirrors for list-packages
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))

;; needed to use things downloaded with the package manager
(package-initialize)

;; Find packages by using M-x list-packages
;; Adding pakcages to the list below ensures that they're installed.
(let* ((packages '(auto-complete
                   ido-vertical-mode
                   monokai-theme
                   leuven-theme
                   multiple-cursors
                   undo-tree
                   ;; if you want more packages, add them here
                   ))
       (packages (remove-if 'package-installed-p packages)))
  (when packages
    (package-refresh-contents)
    (mapc 'package-install packages)))

(dolist (mode '(show-paren-mode         ; show matching parenthesis
                column-number-mode      ; show column number in mode-line
                delete-selection-mode   ; overwrite marked text
                ido-mode                ; changes selection in minibuffer
                ido-everywhere          ; use ido everywhere
                ido-vertical-mode       ; show vertically
                global-undo-tree-mode   ; use undo-tree-mode globally
                ;; Enable more modes by adding them here
                ))
  (when (fboundp mode)
    (funcall mode 1)))

(dolist (mode '(blink-cursor-mode        ; stop blinking cursor
                menu-bar-mode            ; no menubar
                tool-bar-mode            ; no toolbar either
                scroll-bar-mode         ; scrollbar? no
                ;; Disable more modes by adding them here.
                ))
  (when (fboundp mode)
    (funcall mode 0)))

;; No splash screen
(setq inhibit-splash-screen t)

;; Answer with y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; Choose a color-theme

;; Suggested dark theme:
;; (load-theme 'monokai t)

;; Suggested light theme:
(load-theme 'leuven t)

;; get the default config for auto-complete (downloaded with
;; package-manager)
(require 'auto-complete-config)

;; load the default config of auto-complete
(ac-config-default)

;; kills the active buffer, not asking what buffer to kill.
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; adds all autosave-files (i.e #test.txt#, test.txt~) in one
;; directory, avoid clutter in filesystem.
(defvar emacs-autosave-directory
  (concat user-emacs-directory "autosaves/")
  "This variable dictates where to put auto saves. It is set to a directory
called autosaves located wherever your .emacs.d/ is located.")

;; Sets all files to be backed up and auto saved in a single directory.
(setq backup-directory-alist `((".*" . ,emacs-autosave-directory))
      auto-save-file-name-transforms `((".*" ,emacs-autosave-directory t)))

;; now we have to tell emacs where to load these functions. Showing
;; and hiding codeblocks could be useful for all c-like programming
;; (java is c-like) languages, so we add it to the c-mode-common-hook.
(add-hook 'c-mode-common-hook 'hideshow-on)

;; adding shortcuts to java-mode, writing the shortcut folowed by a
;; non-word character will cause an expansion.
(defun java-shortcuts ()
  (define-abbrev-table 'java-mode-abbrev-table
    '(("psv" "public static void main(String[] args) {" nil 0)
      ("sop" "System.out.printf" nil 0)
      ("sopl" "System.out.println" nil 0)))
  (abbrev-mode t))

;; the shortcuts are only useful in java-mode so we'll load them to
;; java-mode-hook.
(add-hook 'java-mode-hook 'java-shortcuts)

;; defining a function that guesses a compile command and bindes the
;; compile-function to C-c C-c
(defun java-setup ()
  (set (make-variable-buffer-local 'compile-command)
       (concat "javac " (buffer-name)))
  (local-set-key (kbd "C-c C-c") 'compile))

;; this is a java-spesific function, so we only load it when entering
;; java-mode
(add-hook 'java-mode-hook 'java-setup)

;; defining a function that sets the right indentation to the marked
;; text, or the entire buffer if no text is selected.
(defun tidy ()
  "Ident, untabify and unwhitespacify current buffer, or region if active."
  (interactive)
  (let ((beg (if (region-active-p) (region-beginning) (point-min)))
        (end (if (region-active-p) (region-end)       (point-max))))
    (whitespace-cleanup)
    (indent-region beg end nil)
    (untabify (if (region-active-p) (region-beginning) (point-min))
              (if (region-active-p) (region-end)       (point-max)))))
;; bindes the tidy-function to C-TAB
(global-set-key (kbd "<C-tab>") 'tidy)
