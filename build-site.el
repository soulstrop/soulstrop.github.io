;; Set the packaage installation directory so that packages aren't stored in the ~/.emacs.d/elpa path
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

;; Customize the html output
(setq org-html-validation-link nil             ;; don't show the validation link
      org-html-head-include-scripts nil        ;; use our own scripts
      org-html-head-include-default-style nil  ;; use our own styles
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             :with-author nil                  ;; don't include author name
             :with-creator t                   ;; include emacs and org versions in footer
             :with-toc t                       ;; include a table of contents
             :section-numbers nil              ;; don't include section numbers
             :time-stamp-file nil)))           ;; don't include time stamp in file

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
