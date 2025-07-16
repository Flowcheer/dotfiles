# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default    
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.gnome.gnome-keyring.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  networking.hostName = "flowers"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Bogota";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
 # console = {
  #   font = "Lat2-Terminus16";
   #  keyMap = "es";
    # useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.greeters.gtk.enable = true;
  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.gvfs.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
   services.pipewire = {
     enable = true;
	alsa.enable = true;
     pulse.enable = true;
   };
  security.polkit.enable = true;
  xdg.mime.enable = true;
  xdg.portal = {
	enable = true;
	wlr.enable = true;
	extraPortals = [pkgs.xdg-desktop-portal-gtk];
	config = {
        	hyprland = {
			default = [
				"hyprland"
			];
		};
	};
};
  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;
  nixpkgs.config.allowUnfree = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.flowcheer = {
     isNormalUser = true;
     shell = pkgs.zsh;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };
# programs that are enabled this way
  programs.nix-ld.enable = true;
  programs.zsh.enable = true;
  programs.firefox.enable = true;
  services.flatpak.enable = true;
  programs.steam = {
	enable = true;
	remotePlay.openFirewall = true;
	dedicatedServer.openFirewall = true;
  };
  programs.appimage = {
	enable = true;
	binfmt = true;
  };
  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
 
  #fonts
  fonts.packages = with pkgs; [
	nerd-fonts.hack
	font-awesome
	noto-fonts
	noto-fonts-color-emoji
	noto-fonts-cjk-sans
];

 #home manager
 home-manager = {
	extraSpecialArgs = { inherit inputs; };
	users = {
	 "flowcheer" = import ./home.nix;
	};
 };

 # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    	wl-clipboard
	adwaita-qt
	libsForQt5.qt5ct
	networkmanagerapplet
	wget
	hyprcursor
	kdePackages.plasma-workspace
	gnome-keyring
	quickshell
	flatpak    
 	pkgs.kitty
	flameshot
     	git
	bluez
	xcur2png
	pavucontrol
	swaynotificationcenter
	grim
	slurp
	pkgs.zed-editor
	pkgs.github-desktop
	hyprpolkitagent
	pkgs.zsh
	qgnomeplatform
	rofi
	wofi
	lightdm
	nautilus
	lightdm-gtk-greeter
	waybar-mpris
	waybar
	kdePackages.ark
	hyprsunset
	gnome-keyring
	kdePackages.qtimageformats
	kdePackages.ffmpegthumbs
	kdePackages.kde-cli-tools
	kdePackages.kio
	kdePackages.kio-extras
	kdePackages.kwayland
	kdePackages.qtsvg
	kdePackages.kimageformats
	kdePackages.kdegraphics-thumbnailers
	kdePackages.dolphin
	kdePackages.kservice
	kdePackages.baloo
   ];
 environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # #};

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

	#wifi module DONT FUCK WITH IT PLEASE
  boot.extraModulePackages = let
	rtl8188eus = config.boot.kernelPackages.callPackage ./wifi.nix {};
	in [
	rtl8188eus
	];
  boot.kernelModules = [ "8188eu" ];
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

