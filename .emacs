
(show-paren-mode t)

;; MELPA
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
    (package-initialize))


;; Theme on startup
(load-theme 'grandshell t)

;; Menu bar mode

(menu-bar-mode -1)

;; Pair mode (delimiters)

(electric-pair-mode 1)

;; Linum mode
(global-linum-mode t)

;;
;; Custom face/function to pad the line number in a way that does not conflict with whitespace-mode
;; https://gist.github.com/whitlockjc/33fdf9bbdb9758dc2cbb
;;
(defface linum-padding
  `((t :inherit 'linum
       :foreground ,(face-attribute 'linum :background nil t)))
  "Face for displaying leading zeroes for line numbers in display margin."
  :group 'linum)

(defun linum-format-func (line)
  (let ((w (length
	    (number-to-string (count-lines (point-min) (point-max))))))
    (concat
     (propertize " " 'face 'linum-padding)
     (propertize (make-string (- w (length (number-to-string line))) ?0)
		 'face 'linum-padding)
     (propertize (number-to-string line) 'face 'linum)
     (propertize " " 'face 'linum-padding)
     )))

(setq linum-format 'linum-format-func)


;; Auto-complete

(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

;; Yasnippets
(require 'yasnippet)
(yas-global-mode t)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets/my-snippets"
	"~/.emacs.d/snippets/yas"
	      ))

;; Remove Yasnippet's default tab key binding
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
;; Set Yasnippet's key binding to shift+tab
(define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)
(define-key yas-minor-mode-map (kbd "\C-c c") 'yas-expand)

;; Auto-comple snippets

;(eval-after-load "auto-complete"
;  '(add-to-list 'ac-sources 'ac-source-yasnippet))
(setq-default ac-sources (push 'ac-source-yasnippet ac-sources))

;;Emmet

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.

(add-hook 'sgml-mode-hook 'ac-emmet-html-setup)
(add-hook 'css-mode-hook 'ac-emmet-css-setup)

;; Standard Jedi.el setting

;(add-hook 'python-mode-hook 'jedi:setup)
;(setq jedi:complete-on-dot t)

;;EMMS

(emms-all)
(emms-default-players)
(setq emms-source-file-default-directory "~/Music/")

;;JS
		 
(add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode))
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq ac-js2-evaluate-calls t)


;; Android mode

(require 'android-mode)
(custom-set-variables '(android-mode-sdk-dir "/media/jonathan/SAMSUNG/android-sdk"))



;;
;; -- Personal commands 
;;



;; Insert Date C-c d

(defun insert-date (prefix)
      "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
      (interactive "P")
      (let ((format (cond
		     ((not prefix) "%d.%m.%Y")
		     ((equal prefix '(4)) "%Y-%m-%d")
		     ((equal prefix '(16)) "%A, %d. %B %Y")))
	    (system-time-locale "de_DE"))
	      (insert (format-time-string format))))

(global-set-key (kbd "C-c d") 'insert-date)

;; Delete line C-c k 

(global-set-key (kbd "C-c k") 'kill-whole-line)

;; Change autosave and backup dir

(setq backup-directory-alist
      `((".*" . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms
            `((".*" "~/.emacs.d/saves" t)))
