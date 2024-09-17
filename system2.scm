;; many parts i peek in Daviwil config
(use-modules (gnu) (nongnu packages linux) (gnu system nss))
(use-service-modules guix desktop dbus sysctl audio linux virtualization   admin )
(use-package-modules bootloaders   libusb terminals  xdisorg certs emacs image-viewers emacs-xyz wm xorg)

(operating-system
  (kernel linux)
  (firmware (list linux-firmware))
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
              (supplementary-groups '("wheel"  ;; sudo                        
                                      "netdev" ;; network devices             
                                      "kvm"                                   
                                      "tty"                                   
                                      "input"                                                                  
                                      "realtime" ;; Enable realtime scheduling 
                                      "lp"       ;; control bluetooth devices  
                                      "audio"    ;; control audio devices      
                                      "video"))) ;; control video devices      
                                                                               
             %base-user-accounts))                                            
   ;; Add the 'realtime' group                                 
   (groups (cons (user-group (system? #t) (name "realtime"))   
                 %base-groups))                                


  (packages (append (list
                     bluez                        
		      bluez-alsa
                      blueman
		      fuse
		     wget
		     emacs-no-x-toolkit           
		     exfat-utils                  
		     fuse-exfat                   
		     git                          
		     gvfs    ;; Enable user mounts
		     libva-utils                  
		     ntfs-3g                      
		     stow                         
		     vim )
                    %base-packages))

  ;; Use the "desktop" services, which include the X11
  ;; log-in service, networking with NetworkManager, and more.
  (services  (append (modify-services %base-services
               (delete login-service-type)
               (delete mingetty-service-type)
               (delete console-font-service-type))
	      (list
                          (service bluetooth-service-type)
                          (service libvirt-service-type
                            (libvirt-configuration
                            (unix-sock-group "libvirt")))
			  (service elogind-service-type)
			  ;;(service docker-service-type))
			  ;;(service nix-service-type)
			  ;;(service avahi-service-type)                                    
			  (service udisks-service-type)                          
			  (service polkit-service-type)                                   
			  (service dbus-root-service-type)                                
			  fontconfig-file-system-service;; Manage the fontconfig cache
(service greetd-service-type                                       
         (greetd-configuration                                     
          (greeter-supplementary-groups (list "video" "input"))    
          (terminals                                               
           (list                                                   
            (greetd-terminal-configuration                         
             (terminal-vt "1")                                     
             (terminal-switch #t))                                 			  
            (greetd-terminal-configuration (terminal-vt "2"))      
            (greetd-terminal-configuration (terminal-vt "3"))))))
;;pam
(service pam-limits-service-type                                     
         (list                                                       
          (pam-limits-entry "@realtime" 'both 'rtprio 99)            
          (pam-limits-entry "@realtime" 'both 'nice -19)             
          (pam-limits-entry "@realtime" 'both 'memlock 'unlimited)))
;; Set up the X11 socket directory for XWayland        
(service x11-socket-directory-service-type)              
;; Add udev rules for MTP (mobile) devices for non-root
(simple-service 'mtp udev-service-type (list libmtp))                     
;; Add udev rules for a few packages                   
;;(udev-rules-service 'pipewire-add-udev-rules pipewire) 
;; Configure the Guix service and ensure we use Nonguix substitutes                               
(simple-service 'add-nonguix-substitutes                                                                                                                                                         
                guix-service-type                                                                                                                                                                
                (guix-extension                                                                                                                                                                  
                 (substitute-urls                                                                                                                                                                
                  (append (list "https://substitutes.nonguix.org")                                                                                                                               
                          %default-substitute-urls))                                                                                                                                             
                 (authorized-keys                                                                                                                                                                
                  (append (list (plain-file "nonguix.pub"                                                                                                                                        
                                            "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))                                        
                          %default-authorized-guix-keys)))))))
  
  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))


