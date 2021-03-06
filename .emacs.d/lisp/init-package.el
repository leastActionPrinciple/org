(provide 'init-package)

(use-package restart-emacs)

(use-package benchmark-init
  :init (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate))

(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-headline-bullets-list '("○" "⚙" "✡" "◈" "▷" "◇" "✙" "✤" "✥" "◌" "⊙" "♢" "◉"))
  ;; This is usually the default, but keep in mind it must be nil
  (org-hide-leading-stars nil)
  ;; This line is necessary.
  (org-superstar-leading-bullet ?\s)
  )

(use-package sage-shell-mode
  :init (sage-shell:define-alias)
  :hook ('sage-shell-mode-hook . #'eldoc-mode)
  ('sage-shell:sage-mode-hook . #'eldoc-mode)
   )

(use-package org-roam
  :after org
  :init (setq org-roam-v2-ack t) ;; acknowledge v2 upgrade
  :custom
  (org-roam-directory "~/orgmode/note")
  (org-roam-capture-templates '(
			       ("d" "default" plain "%?"
				:target (file+head "${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)
			      ))
  :config
  (org-roam-setup)
  :bind (("C-c n f" . org-roam-node-find) ;; 添加节点
         ("C-c n r" . org-roam-node-random) ;; 	    
         (:map org-mode-map
               (("C-c n i" . org-roam-node-insert)
                ("C-c n o" . org-id-get-create)
                ("C-c n t" . org-roam-tag-add)
                ("C-c n a" . org-roam-alias-add)
                ("C-c n l" . org-roam-buffer-toggle)))))

(use-package deft
  :config
  (setq deft-directory org-directory
        deft-recursive t
        deft-strip-summary-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n"
        deft-use-filename-as-title t)
  :bind
  ("C-c n d" . deft))
