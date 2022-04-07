(provide 'init-kbd)

(use-package emacs
  :config (defalias 'yes-or-no-p 'y-or-n-p))

(global-set-key (kbd "C-x C-m") (lambda() (interactive)(find-file "~/filemap.org")))
