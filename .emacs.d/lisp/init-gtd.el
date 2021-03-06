(provide 'init-gtd)

;;org-agenda
(setq org-agenda-files '(concat org-directory "gtd"))
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
(setq org-default-inbox-file (concat org-directory "gtd/inbox.org"))
(setq org-capture-templates
      '(
	("t" "Tasks" entry
	 (file+headline org-default-inbox-file "Tasks")
	 "* INBOX %^{任务名}\n"
	 )
 	("p" "Projects" entry
	 (file+headline org-default-inbox-file "Projects")
	 "* INBOX %^{项目名} :project:\n")))


;;setting for tag
(setq org-tag-alist '(("project" . ?p) ("daily" . ?d) ("weekly" . ?w)
		      ("@computer" . ?c) ("@book" . ?b) ("@out" . ?o)))

;;set refile
(setq org-refile-targets `(
			    (nil :maxlevel . 9)
			    (,(directory-files-recursively "~/orgmode/gtd" "org$") :maxlevel . 9)
))
(setq org-refile-use-outline-path 'full-file-path)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)

;;location for archive
(setq org-archive-location (concat org-directory "gtd/_archive/" (format-time-string "%Y%m") "_archive.org::datetree/* Archive from %s"))

;;information added to property when a subtree is moved
(setq org-archive-save-context-info '(time file ltags itags todo category olpath))
(put 'downcase-region 'disabled nil)
