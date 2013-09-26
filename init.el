;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs configuration for Clojure development
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Configure Marmalade
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
;;(package-refresh-contents)

;; Utils

(defun install-first (extension)
  (unless (package-installed-p extension)
  (package-install extension)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Path configuration
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

;; Font size
(set-face-attribute 'default nil :height 140)

;; Themes
(install-first 'color-theme-solarized)
(load-theme 'solarized-dark t)

;; IDO mode
(ido-mode t)

;; Show parens
(show-paren-mode 1)


;; Paredit
(install-first 'paredit)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

;; Rainbow delimiters
(install-first 'rainbow-delimiters)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

;; Autocomplete
(install-first 'auto-complete)

;; Magit
(install-first 'magit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Clojure mode
;; https://github.com/clojure-emacs/clojure-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(install-first 'clojure-mode)

;; Paredit
(add-hook 'clojure-mode-hook 'paredit-mode)

;; Rainbow delimiters
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

;; Enable Clojure mode for clojurescript
(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; nREPL
;; https://github.com/clojure-emacs/nrepl.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(install-first 'nrepl)

;; Enable eldoc in clojure buffers
(add-hook 'nrepl-interaction-mode-hook
  'nrepl-turn-on-eldoc-mode)

;; Enable error buffers in the REPL
(setq nrepl-popup-stacktraces-in-repl t)

;; Show port in nREPL buffer name
(setq nrepl-buffer-name-show-port t) 

;; Enable camel case
(add-hook 'nrepl-mode-hook 'subword-mode)

;; Enable paredit in buffer
(add-hook 'nrepl-mode-hook 'paredit-mode)

;; Enable rainbow delimiters
(add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)

;; nREPL Autocomplete
;; https://github.com/clojure-emacs/ac-nrepl

(install-first 'ac-nrepl)

(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(add-hook 'clojure-mode-hook 'ac-nrepl-setup)


(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode 'clojure-mode))


;; Popup documentation
(define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
