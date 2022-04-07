(setq org-directory "~/orgmode/")

(setq initial-buffer-choice "~/filemap.org")

(add-to-list 'load-path
	     (expand-file-name (concat user-emacs-directory "lisp")))
(require 'init-elpa)
(require 'init-ui)
(require 'init-kbd)
(require 'init-gtd)
(require 'init-package)

(setq gc-cons-threshold most-positive-fixnum)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-process-type 'stack-ghci)
 '(org-babel-load-languages
   '((emacs-lisp . t)
     (haskell . t)
     (julia-vterm . t)
     (shell . t)
     (latex . t)
     (dot . t)))
 '(org-latex-classes
   '(("org-note" "\\documentclass[fontset=windows]{article}
                \\usepackage[colorlinks=true,linkcolor=red]{hyperref}
                \\usepackage{ctex}
                \\usepackage{tasks}
                \\settasks{
                         label={\\Alph*.}
                }
                [NO-DEFAULT-PACKAGES]
                [PACKAGES]
                [EXTRA]")
     ("article" "\\documentclass[11pt,fontset=windows]{article}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
     ("report" "\\documentclass[11pt]{report}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("book" "\\documentclass[11pt]{book}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
 '(org-latex-packages-alist '(("" "ctex" t) ("" "mathrsfs" t)))
 '(package-selected-packages
   '(deft org-roam-server org-roam-server-mode org-roam sage-shell-mode smart-mode-line ob-racket restart-emacs tikz youdao-dictionary pdf-tools org-pomodoro julia-snail ob-browser julia-mode rust-mode use-package racket-mode atom-dark-theme org-gtd haskell-mode ## yasnippet cdlatex auctex))
 '(word-wrap nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;字典
(setq url-automatic-caching t)
(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point)
(global-set-key (kbd "C-c v") 'youdao-dictionary-play-voice-at-point)

;; org自动换行
(global-visual-line-mode 1); 1 for on, 0 for off

(add-hook 'org-mode-hook
	  (lambda()
	    (setq truncate-lines nil)))

(pdf-loader-install)

;; latex自动保存自动解析
(setq TeX-auto-save t)
(setq TeX-parse-self t)

;; latex文件包含
(setq-default TeX-master nil)

(add-hook 'LaTex-mode-hook 'turn-on-cdlatex) ; with AUCTex LaTex mode
(add-hook 'latex-mode-hook 'turn-on-cdlatex) ; with Emacs latex mode
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

;; org导出latex
(require 'ox-latex)
(setq org-latex-compiler "xelatex")

;;设置为全局模式,在任何mode中是生效的

(yas-global-mode 1)

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets" ;;personal snippets
	"~/.emacs.d/elpa/yasnippet-20200604.246/snippets"
	))
(put 'upcase-region 'disabled nil)

;(use-package ob-racket
;  :after org
;  :config
;  (append '((racket . t) (scribble . t)) org-babel-load-languages)
;)


