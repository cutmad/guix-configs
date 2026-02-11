

(use-modules                                                     
  (gnu home)
  (guix gexp)
  (gnu packages admin)
  (gnu services)                                                 
  (gnu home services)                                            
  (gnu home services shells)                                                                        
  (gnu packages)                           
  (gnu packages freedesktop)                                     
  (gnu packages glib)                                            
  (gnu packages fonts)                                           
  (gnu packages video)                                           
  (gnu packages gstreamer)                                       
  (gnu packages pulseaudio)                                      
  (gnu packages package-management)                              
  (gnu packages file-systems)                                    
  (gnu packages image-viewers)                                   
  (gnu packages emacs)                                           
  (gnu packages qt)
  (gnu packages wm)
  (gnu packages xdisorg)
  (gnu packages image)
  (gnu packages shells)
  (gnu packages linux)
  (gnu packages gnuzilla)
  (gnu packages compression)                                     
  (gnu packages password-utils)                                  
  (gnu packages libusb)                                          
  (gnu packages cpp)                                             
  (gnu packages music)                                           
  (gnu packages kde)                                             
  (gnu packages gimp)                                            
  (gnu packages graphics)                                        
  (gnu packages game-development)                                
  (gnu packages pdf)                                             
  (gnu packages shellutils)                                      
  (gnu packages video)
  (gnu packages unicode)
  (gnu packages cran)  
  (gnu home services ssh)
  (gnu home services shepherd)
  (gnu home services gnupg)
  (gnu home services sound)
  (gnu home services desktop)
  (gnu packages emacs-xyz)
  (gnu packages terminals)                                       
  (gnu packages xorg))         ; для xwayland и совместимости

  


(home-environment
 (packages
  (list
         ;; Wayland / Hyprland stack          
         hyprland                             
         hyprpaper 
   	     swaylock
         waybar                               
         hypridle                             
         hyprlock                             
         hyprcursor                           
         hyprutils                            
         hyprland-qtutils                     
                                              
         ;; Notifications                     
         mako                                 
                                              
         ;; Compositor helpers / utilities    
         wl-clipboard                         
         grim                                 
;;         grimshot    проверить необходимость                         
         slurp                                
         xdg-desktop-portal                   
         xdg-desktop-portal-hyprland          
         xdg-desktop-portal-gtk
         xdg-utils                            
         xdg-dbus-proxy                       
                                              
         ;; Terminals / shells / emulators    
         foot                                 
         sakura                               
         alacritty                            
         fuzzel                               
         emacs                                
                                              
         ;; Notifications / sound / media     
         wireplumber                          
         playerctl                            
         mpv                                  
         mpv-mpris                            
         gstreamer                            
         alsa-utils                           
         pavucontrol                          
         imv
         mpv
	 vlc
	 udiskie
                                              
         ;; X compatibility / misc            
         xorg-server-xwayland                 
         nix                                  
         flatpak                              
                                              
         ;; Fonts                             
	  font-dejavu               ; DejaVu font family for general use       
	  font-adobe-source-code-pro ; Monospace font for coding               
	  font-adobe-source-han-sans ; CJK font for Chinese, Japanese, Korean  
	  font-adobe-source-sans-pro ; Sans-serif font for documents           
	  font-adobe-source-serif-pro ; Serif font for documents               
	  font-anonymous-pro        ; Monospace font for programming           
	  font-anonymous-pro-minus  ; Variant of Anonymous Pro                 
	  font-awesome              ; Icon font for UI elements                
	  font-cns11643             ; CJK font for traditional Chinese         
	  font-cns11643-swjz        ; Simplified Chinese variant of CNS11643   
	  font-comic-neue           ; Casual comic-style font                  
	  font-culmus               ; Hebrew fonts                             
	  font-dosis                ; Rounded sans-serif font                  
	  font-dseg                 ; Retro-style segmented display font       
	  font-fantasque-sans       ; Monospace font with a quirky design      
	  font-fira-code            ; Monospace font with ligatures for coding 
	  font-fira-mono            ; Monospace font for programming           
	  font-fira-sans            ; Sans-serif font for UI and documents     
	  font-fontna-yasashisa-antique ; Japanese font with a soft aesthetic  
	  font-google-noto-emoji    ; Font Emojis                              
	  font-google-material-design-icons ; Material Design icons            
	  font-google-noto          ; Comprehensive font for multiple scripts  
	  font-google-roboto        ; Modern sans-serif font                   
	  font-gnu-freefont         ; GNU FREE                                 
	  font-hack                 ; Monospace font for coding                
	  font-hermit               ; Monospace font with clean design         
	  font-ibm-plex             ; Modern font family for UI and documents  
	  font-inconsolata          ; Monospace font for programming           
	  font-iosevka              ; Highly customizable monospace font       
	  font-iosevka-aile         ; Iosevka variant with cursive style       
	  font-iosevka-etoile       ; Iosevka variant with decorative style    
	  font-iosevka-slab         ; Iosevka with slab serifs                 
	  font-iosevka-term         ; Iosevka optimized for terminals          
	  font-iosevka-term-slab    ; Iosevka terminal font with slab serifs   
	  font-ipa-mj-mincho        ; Japanese Mincho font                     
	  font-jetbrains-mono       ; Monospace font for developers            
	  font-lato                 ; Sans-serif font for modern design        
	  font-liberation           ; Open-source font family                  
	  font-linuxlibertine       ; Serif font for documents                 
	  font-lohit                ; Fonts for Indian scripts                 
	  font-meera-inimai         ; Tamil font                               
	  font-mononoki             ; Monospace font for coding                
          font-mplus-testflight     ; Japanese font family                       
          font-public-sans          ; Clean sans-serif font                      
          font-rachana              ; Malayalam font                             
          font-sarasa-gothic        ; CJK font with gothic style                 
          font-sil-andika           ; Font for literacy and education            
          font-sil-charis           ; Serif font for publishing                  
          font-sil-gentium          ; High-quality serif font                    
          font-tamzen               ; Monospace bitmap font                      
          font-terminus             ; Monospace bitmap font                      
	  font-tex-gyre             ; Professional font family for documents   
	  font-un                   ; Korean font                              
	  font-vazir                ; Persian font                             
	  font-wqy-microhei         ; CJK font for Chinese                     
	  font-wqy-zenhei           ; CJK font for Chinese                     
	  font-adobe100dpi          ; Adobe bitmap fonts (100 DPI)             
	  font-adobe75dpi           ; Adobe bitmap fonts (75 DPI)              
	  font-cronyx-cyrillic      ; Cyrillic bitmap fonts                    
	  font-dec-misc             ; Miscellaneous bitmap fonts               
	  font-isas-misc            ; Miscellaneous bitmap fonts               
	  font-micro-misc           ; Small bitmap fonts                       
	  font-misc-cyrillic        ; Cyrillic bitmap fonts                    
	  font-misc-ethiopic        ; Ethiopic bitmap fonts                    
	  font-misc-misc            ; Miscellaneous bitmap fonts               
	  font-mutt-misc            ; Bitmap fonts for Mutt                    
	  font-schumacher-misc      ; Classic bitmap fonts                     
	  font-screen-cyrillic      ; Cyrillic fonts for terminal              
	  font-sony-misc            ; Sony bitmap fonts                        
	  font-sun-misc             ; Sun bitmap fonts                         
	  font-util                 ; Font utilities                           
	  font-winitzki-cyrillic    ; Cyrillic bitmap fonts                    
	  font-xfree86-type1        ; Type1 fonts for X11                      
	  font-google-noto-emoji    ; Noto emoji font                          
	  font-openmoji             ; Open-source emoji font                   
	unicode-emoji                                                          
	r-emojifont                                                            
	emacs-emojify                                                          
	emacs-company-emoji
	 
         ;; Authentication / password managers
         password-store                       
         keepassxc                            
                                              
         ;; Browser                           
         icecat                               
                                              
         ;; Graphics / media editing          
         krita                                
         gimp                                 
         blender                              
                                              
         ;; Game engine                       
         godot                                
                                              
         ;; Documents / PDF viewer            
         zathura                              
         zathura-pdf-mupdf                    
                                              
         ;; Archive tools                     
         p7zip                                
         unrar-free                             
                                              
         ;; Utilities                         
         trash-cli                            
       )) ; end list                          

       (services (append
          (list

		    (service home-dbus-service-type)
           (simple-service 'some-useful-env-vars-service
                           home-environment-variables-service-type
                           '(("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share")))
           (simple-service 'custom-dbus-services home-dbus-service-type (map specification->package
                               (list "xdg-desktop-portal-hyprland" "xdg-desktop-portal" "blueman")))

                 (service home-pipewire-service-type)))))














