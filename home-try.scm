;;i do not know how it will work. just experiments

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
	     (gnu packages glib)
	     (gnu packages gnome-xyz)
	     (gnu packages kde-frameworks)
	     (gnu packages gnome)
	     (gnu packages fonts)
             (gnu home services shells)
             (gnu packages freedesktop)
             (dwl-guile home-service)
             (dwl-guile patches))
             
;;(use-package-modules shellutils)

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
 (packages (specifications->packages (list "sway"
					   "foot"
                                           "inxi"

					   "swayidle"
					   "swaylock"
					   "waybar"
					   "fuzzel"
					   "mako"
					   "gammastep"
                                           
					   "grimshot" ;; grimshot --notify copy area
			;;still looking for some nice players

					   ;; Compatibility for older Xorg applications
					   "xorg-server-xwayland"

 
					   ;; Flatpak and XDG utilities
					   "flatpak"
					   "xdg-desktop-portal"
					   "xdg-desktop-portal-gtk"
					   "xdg-desktop-portal-wlr"
					   "xdg-utils" ;; For xdg-open, etc
					   "xdg-dbus-proxy"
					   ;;        shared-mime-info
					   ;;        (list glib "bin")

					   ;; Appearance
					   "matcha-theme"
					   "papirus-icon-theme"
					   "breeze-icons" ;; For KDE apps
					   "gnome-themes-extra"
					   "adwaita-icon-theme"

					   ;; Fonts
					   ;; font-jost
					   "font-iosevka-ss08"
					   "font-iosevka-aile"
					   "font-jetbrains-mono"
					   "font-google-noto"
					   "font-google-noto-emoji"
					   "font-liberation"
					   "font-google-noto-sans-cjk"
					   "font-google-noto-serif-cjk"
					   "font-hack"

					   ;;some
					   "keepassxc"
					   "libnotify"
					   "librewolf"
					   "libsteam"
					   "mpv"
					   "steam-devices-udev-rules"
					    )))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services 
   (list (service home-fish-service-type)
         (service home-dwl-guile-service-type))))
