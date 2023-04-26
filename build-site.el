;; Set the packaage installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path
(require 'package)
(setq package-user-dir (expand-file-name "./packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; install dependencies
(package-install 'htmlize)

;; load the publishing system
(require 'ox-publish)

(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "./content"
             :publishing-directory "./public"
             :publishing-function 'org-html-publish-to-html
             :with-author nil
             :with-creator t
             :with-toc t
             :section-numbers nil
             :time-stamp-file nil)))

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
