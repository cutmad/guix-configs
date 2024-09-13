;; This is an operating system configuration template
;; for a "desktop" setup without full-blown desktop
;; environments.

(use-modules (gnu)  (gnu system nss)) ;(nongnu packages linux)
(use-service-modules desktop xorg linux admin )
(use-package-modules bootloaders terminals  xdisorg certs emacs image-viewers emacs-xyz wm xorg)

(operating-system
  ;(kernel linux)
  ;(firmware (list linux-firmware))
  (host-name "guix-machine")
  (timezone "Europe/Moscow")
  (locale "en_US.utf8")

  ;; Use the UEFI variant of GRUB with the EFI System
  ;; Partition mounted on /boot/efi.
  (bootloader (bootloader-configuration
                (bootloader grub-efi-removable-bootloader)
                (targets '("/boot/efi"))))

  ;; Assume the target root file system is labelled "my-root",
  ;; and the EFI System Partition has UUID 1234-ABCD.
  (file-systems (append
                 (list (file-system
                         (device (file-system-label "my-root"))
                         (mount-point "/")
                         (type "ext4"))
                       (file-system
                         (device (file-system-label "my-home"))
                         (mount-point "/home")
                         (type "ext4"))
		       (file-system
                         (device (file-system-label "inside"))
                         (mount-point "/mnt/inside")
                         (type "ext4"))
                       (file-system
                         (device (uuid "F653-D445" 'fat))
                         (mount-point "/boot/efi")
                         (type "vfat")))
                 %base-file-systems))
(swap-devices (list (swap-space
			(target "/swapfile"))))

  (users (cons (user-account
                (name "name")
                (comment "name")
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video")))
               %base-user-accounts))

  ;; Add a bunch of window managers; we can choose one at
  ;; the log-in screen with F1.
  (packages (append (list
                     ;; window managers
                     sway waybar swaybg swaynotificationcenter wofi swayidle swaylock
                     ;; terminal emulator
                     kitty alacritty foot
		     ;;fonts ill move them to home later
                                             
		     ;; for HTTPS access
                     nss-certs)
                    %base-packages))

  ;; Use the "desktop" services, which include the X11
  ;; log-in service, networking with NetworkManager, and more.
  (services (cons* (service pam-limits-service-type
		(list
			(pam-limits-entry "*" 'both 'nofile 524288)))
	                  (modify-services   %desktop-services
          (delete gdm-service-type))))                
  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))

























