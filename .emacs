;; 配置MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(exec-path
   '("/usr/bin/rustc" "/usr/bin/cargo" "/home/ttt/.cargo/bin/rust-script" "/home/ttt/.local/bin" "/home/ttt/.local/bin" "/usr/local/bin" "/usr/bin" "/bin" "/usr/local/sbin" "/usr/lib/jvm/default/bin" "/usr/bin/site_perl" "/usr/bin/vendor_perl" "/usr/bin/core_perl" "/usr/lib/jvm/default/bin"))
 '(haskell-process-type 'stack-ghci)
 '(inhibit-startup-screen t)
 '(org-babel-load-languages
   '((emacs-lisp . t)
     (haskell . t)
     (julia-vterm . t)
     (shell . t)
     (latex . t)))
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
   '(tikz youdao-dictionary pdf-tools org-pomodoro julia-snail ob-browser julia-mode rust-mode use-package racket-mode atom-dark-theme org-gtd haskell-mode ## yasnippet cdlatex auctex))
 '(tool-bar-mode nil)
 '(word-wrap nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; 字符编码
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

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

(add-to-list 'load-path "~/.emacs.d/my/ob-racket")

(use-package ob-racket
  :after org
  :config
  (append '((racket . t) (scribble . t)) org-babel-load-languages)
)

;;org-agenda
(setq org-agenda-files '("~/orgmode/gtd"))
(global-set-key (kbd "C-c a") 'org-agenda)

(setq org-agenda-custom-commands
        '(("w" . "任务安排")
          ("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
          ("wb" "重要且不紧急的任务" tags-todo "+PRIORITY=\"B\"")
          ("wc" "不重要且紧急的任务" tags-todo "+PRIORITY=\"C\"")
	  ("wd" "不重要且紧急的任务" tags-todo "+PRIORITY=\"D\"")
          ("W" "Weekly Review"
           ((stuck "") ;; 尚未管理的任务 查看org-stuck-projects
            (tags-todo "project")
            (tags-todo "daily")
            (tags-todo "weekly")
            ))
          ))

;;set status for TODO.
(setq org-todo-keywords '((sequence 
                         "INBOX"
                         "NEXT(n)"
                         "LATER(l)"
                         "MAYBE(m)"
                         "|" "CANCEL(c)" "DONE(d)"
                         )))

;; color for todo keywords
(setq org-todo-keyword-faces '(
("INBOX" . (:foreground "blue" :weight "bold")) 
("NEXT" . org-warning)
("LATER" . "yellow")
("MAYBE" . "purple")
("DONE" . "green")
("CANCEL" . "grey")
))

;;add timestamp when todo change to done.
(setq org-log-done 'time)

;;Settings for global id link.
(require 'org-id)
(setq org-id-link-to-org-use-id t)
(global-set-key (kbd "C-c l") 'org-store-link)

;;set priority
(setq org-highest-priority ?A)
(setq org-lowest-priority ?D)
(setq org-default-priority ?A)
(setq org-priority-faces '(
                           (?A . org-warning)
                           (?B . (:background "DodgerBlue" :foreground "black" :weight "bold")) 
                           (?C . (:foreground "SkyBlue" :weight "bold"))
                           (?D . (:foreground "DodgerBlue" :weight "bold")) 
))

;;setting for gtd captures
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-directory "~/orgmode/")
(setq org-default-notes-file (concat org-directory "inbox.org"))
(setq org-capture-templates '(
                              ("t" "Tasks" entry (file+headline "inbox.org" "Tasks") "* INBOX %^{任务名}\n")
			      ("p" "Projects" entry (file+headline "inbox.org" "Projects") "* INBOX %^{项目名} :project:\n")
                              ("n" "Notes" entry (file+headline "inbox.org" "Notes")  "* %^{标题}\n%?\n")
			      ("i" "Ideals" entry (file+headline "inbox.org" "Ideals")  "* %^{标题}\n%?\n")
			      ("e" "Exercises" entry (file+headline "inbox.org" "Exercises")  "%?\n")))

;;set tags
(setq org-tag-alist '(("project" . ?p) ("daily" . ?d) ("weekly" . ?w)
		      ("@computer" . ?c) ("@book" . ?b) ("@out" . ?o)))

;;set refile
(setq org-refile-targets `(
			    (nil :maxlevel . 9)
			    (,(directory-files-recursively "~/orgmode/" "org$") :maxlevel . 9)
))
(setq org-refile-use-outline-path 'full-file-path)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)

;;location for archive
(setq org-archive-location (concat org-directory "gtd/_archive/" (format-time-string "%Y%m") "_archive.org::datetree/* Archive from %s"))

;;information added to property when a subtree is moved
(setq org-archive-save-context-info '(time file ltags itags todo category olpath))
