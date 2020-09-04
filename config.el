;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(require 'company)
(setq company-idle-delay 0.2
      company-minimum-prefix-length 3)

;; temporarily turn it off
(require 'prettier-js)
(add-hook 'js2-mode-hook 'prettier-js-mode)

(setq doom-theme 'doom-one)

;;(setq doom-font (font-spec :family "Monoid" :size 18))
(setq doom-font (font-spec :family "Fira Code" :size 18))

;; Haskell stylish 
;;(setq haskell-stylish-on-save t)

;; Enable mouse support
;;(unless window-system
;;  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
;;  (global-set-key (kbd "<mouse-5>") 'scroll-up-line))

(if (featurep 'ns)
  (progn
    (global-set-key (kbd "<mouse-4>") (kbd "<wheel-up>"))
    (global-set-key (kbd "<mouse-5>") (kbd "<wheel-down>"))))

;; javascript/typescript support
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;;(setq tide-format-options '(:indentSize 2 :tabSize 2 :insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))

;; formats the buffer before saving
;;(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; enable typescript-tslint checker
;;(flycheck-add-mode 'typescript-tslint 'web-mode)

(add-hook 'js2-mode-hook #'setup-tide-mode)
;; configure javascript-tide checker to run after your default javascript checker
;;(flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "jsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; configure jsx-tide checker to run after your default jsx checker
;;(flycheck-add-mode 'javascript-eslint 'web-mode)
;;(flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)

;;(use-package tide
;;  :ensure t
;;  :after (typescript-mode company flycheck)
;;  :hook ((typescript-mode . tide-setup)
;;         (typescript-mode . tide-hl-identifier-mode)
;;         (before-save . tide-format-before-save)))

;; Set the neo-window-width to the current width of the
  ;; neotree window, to trick neotree into resetting the
  ;; width back to the actual window width.
  ;; Fixes: https://github.com/jaypei/emacs-neotree/issues/262
(setq neo-window-fixed-size nil)
