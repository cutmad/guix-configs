(use-modules                      
 (gnu)                            
 (gnu system)                     
 (gnu system nss)                 
 (nongnu packages linux)          
 (gnu packages)                   
 (gnu packages package-management)
 (gnu system shadow)              
 (gnu packages android)           
 (gnu system setuid)              
 (srfi srfi-1)
 (gnu packages nss)
 (gnu packages freedesktop)
 (gnu services))                  
                                  
(use-service-modules              
 desktop                          
 dbus                             
 networking                       
 sysctl                           
 pm                               
 virtualization                   
 docker                           
 admin                            
 nix                              
 xorg)                            
                                  
(use-package-modules              
 certs                            
 bootloaders                      
 vim                              
 linux                            
 libusb                           
 gnome                            
 audio                            
 games
 fonts
 networking                       
 wget                             
 xdisorg                          
 wm                               
 terminals                        
 version-control                  
 file-systems)
(operating-system                                                
 (kernel linux)                                                  
 (firmware (list linux-firmware))                                
 (locale "en_US.utf8")                                           
 (timezone "Europe/Moscow")                                      
 (keyboard-layout (keyboard-layout "us"))                        
 (host-name "cosm")                                              
                                                                 
 (bootloader                                                     
  (bootloader-configuration                                      
   (bootloader grub-efi-bootloader)                              
   (targets '("/boot/efi"))))                                    
                                                                 
 (file-systems                                                   
  (append                                                        
   (list                                                         
    (file-system                                                 
     (device (file-system-label "my-root"))                      
     (mount-point "/")                                           
     (type "btrfs"))                                             
    (file-system                                                 
     (device (file-system-label "my-home"))                      
     (mount-point "/home")                                       
     (type "ext4"))                                              
    (file-system                                                 
     (device (uuid "16EE-4E0D" 'fat))                            
     (mount-point "/boot/efi")                                   
     (type "vfat")))                                             
   %base-file-systems))                                          
                                                                 
 (swap-devices                                                   
  (list                                                          
   (swap-space                                                   
    (target (uuid "bd0e1ed9-2b30-4a90-af6d-97eca81587ad")))))    
                                                                 
 (users                                                          
  (cons*                                                         
   (user-account                                                 
    (name "same")                                                
    (comment "thesame")                                          
    (group "users")                                              
    (supplementary-groups                                        
     '("wheel" "netdev" "steam" "kvm" "libvirt"                            
       "tty" "realtime" "adbusers"                               
       "lp" "audio" "video")))                                   
   %base-user-accounts))
 (groups 
  (cons 
   (user-group 
    (system? #t) 
    (name "realtime"))
   %base-groups))

(packages           
 (append            
  (list             
   vim
   jmtpfs
   bluez
  ;; nss-certs
   blueman
   gvfs
   ntfs-3g
   fuse-exfat
   exfat-utils
   wget
   libimobiledevice
;;   libmtp
  ;; xdg-utils
   git)             
  %base-packages))



(services ;;base-services
 (append  (modify-services %base-services                      
	                   (delete login-service-type)         
	                   (delete mingetty-service-type)
			   (delete console-font-service-type))      
	                    
  
    (list
      ;;pam
      (service pam-limits-service-type
               (list
                (pam-limits-entry "@realtime" 'both 'rtprio 99)
                (pam-limits-entry "@realtime" 'both 'nice -19)
                (pam-limits-entry "@realtime" 'both 'memlock 'unlimited)))
      ;;console-font
      (service console-font-service-type                            
         (map (lambda (tty)                                   
                ;; Use a larger font for HIDPI screens        
                (cons tty (file-append                        
                           font-terminus                      
                           "/share/consolefonts/ter-132n")))  
              '("tty1" "tty2" "tty3")))                       

   ;;greetd   
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
;;dbus, polkit, elogin 
 (service dbus-root-service-type)
      (service polkit-service-type)
      (service elogind-service-type)
      ;;network
      (service network-manager-service-type
               (network-manager-configuration
                (vpn-plugins (list network-manager-openvpn))))
      (service wpa-supplicant-service-type)
      ;;x11-socket
      (service x11-socket-directory-service-type)
      ;;lock-screen
      (service screen-locker-service-type
               (screen-locker-configuration
                (name "hyprlock")
                (program (file-append "/bin/hyprlock"))
                (using-pam? #t)
                (using-setuid? #f)))
      ;;bluetooth
      (service bluetooth-service-type
               (bluetooth-configuration (auto-enable? #t)))
      ;;time-service
      (service ntp-service-type)
      ;;containers, nix
      (service containerd-service-type)
      (service docker-service-type)
      (service nix-service-type)
      ;;virtual
      (service libvirt-service-type
               (libvirt-configuration
                (unix-sock-group "libvirt")
                (tls-port "16555")))
      ;;udiskie
      (service udisks-service-type)
      ;;mounts
      (simple-service 'mount-setuid-helpers
                      privileged-program-service-type
                      (map file-like->setuid-program
                           (list (file-append ntfs-3g "/sbin/mount.ntfs-3g"))))
      ;;nonguix
;;                     (simple-service 'add-nonguix-substitutes                                                                                                                    
;;                                     guix-service-type                                                                                                                           
;;                                     (guix-extension                                                                                                                             
;;                                      (substitute-urls                                                                                                                           
;;                                       (cons* "https://nonguix-proxy.ditigal.xyz"                                                                                                
;;                                              %default-substitute-urls))                                                                                                         
;;                                      (authorized-keys                                                                                                                           
;;                                       (append (list (plain-file "nonguix.pub"                                                                                                   
;;                                                                 "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))   
;;                                               %default-authorized-guix-keys))))                                                                                                 
      ;;udev
      (udev-rules-service 'steam steam-devices-udev-rules #:groups '("steam"))
      (simple-service 'mtp udev-service-type (list libmtp))
      (udev-rules-service 'android android-udev-rules #:groups '("adbusers"))))))
