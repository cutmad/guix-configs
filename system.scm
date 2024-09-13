;; a little dirty but works. i think...

(use-modules (gnu)  (gnu system nss)   (nongnu packages linux))
(use-service-modules desktop xorg nix  virtualization linux admin )
(use-package-modules bootloaders terminals linux vim file-systems version-control audio gnome video package-management xdisorg certs emacs networking xorg libusb)

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
					"lp"       ;; control bluetooth devices    
					"audio"    ;; control audio devices        		
					"video"))) ;; control video devices        
                                        %base-user-accounts))                       

  ;; Add a bunch of window managers; we can choose one at
  ;; the log-in screen with F1.
  (packages (append (list
                      bluez                        
		      bluez-alsa
                      blueman
		      fuse
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
  (services (cons* (service bluetooth-service-type)
                   (service libvirt-service-type
         (libvirt-configuration
          (unix-sock-group "libvirt")
          (tls-port "16555")))




		   
		   (simple-service 'mtp udev-service-type (list libmtp))
		   (service nix-service-type)
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
		                                            %default-authorized-guix-keys))))                                                                                                    







	     (service pam-limits-service-type
		(list
			(pam-limits-entry "*" 'both 'nofile 524288)))
	                  (modify-services   %desktop-services
          (delete gdm-service-type))))                
  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
