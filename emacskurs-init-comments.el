;; no splash screen


;; show matching parenthesis


;; answer with y/n


;; stop blinking cursor


;; overwrite marked text


;; show column number in mode-line


;; needed to use things downloaded with the package manager


;; add mirrors for list-packages


;; choose a color-theme (downloaded with package-manager)


;; get the default config for auto-complete (downloaded with
;; package-manager)


;; load the default config of auto-complete


;; enable ido-mode, this changes the way files are selected in the
;; minibuffer


;; no menubar


;; no toolbar either


;; scrollbar? no


;; global-linum-mode shows line numbers in all buffers, exchange 0
;; with 1 to enable this feature


;; kills the active buffer, not asking what buffer to kill.


;; adds all autosave-files (i.e #test.txt#, test.txt~) in one
;; directory, avoid clutter in filesystem.


;; defining a function that sets more accessible keyboard-bindings to
;; hiding/showing code-blocs


;; now we have to tell emacs where to load these functions. Showing
;; and hiding codeblocks could be useful for all c-like programming
;; (java is c-like) languages, so we add it to the c-mode-common-hook.


;; adding shortcuts to java-mode, writing the shortcut folowed by a
;; non-word character will cause an expansion.


;; the shortcuts are only useful in java-mode so we'll load them to
;; java-mode-hook.


;; defining a function that guesses a compile command and bindes the
;; compile-function to C-c C-c


;; this is a java-spesific function, so we only load it when entering
;; java-mode


;; defining a function that sets the right indentation to the marked
;; text, or the entire buffer if no text is selected.


;; bindes the tidy-function to C-TAB
