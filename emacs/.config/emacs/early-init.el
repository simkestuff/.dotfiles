(setq gc-cons-threshold 10000000)
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)

;; Silence stupid startup message
(setq inhibit-startup-echo-area-message (user-login-name))

;; Default frame configuration: full screen, good-looking title bar on macOS
(setq frame-resize-pixelwise t)
(setq default-frame-alist '((fullscreen . maximized)

                            ;; You can turn off scroll bars by uncommenting these lines:
                            ;;(vertical-scroll-bars . nil)
                            ;;(horizontal-scroll-bars . nil)

                            ;; Setting the face in here prevents flashes of
                            ;; color as the theme gets activated
                            ;;(background-color . "#000000")
                            ;;(foreground-color . "#ffffff")
                            ;;(ns-appearance . dark)
                            ;;(ns-transparent-titlebar . t)
			    ))

(tool-bar-mode -1)                      
(menu-bar-mode -1)
(scroll-bar-mode -1)
