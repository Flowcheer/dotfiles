{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "flowcheer";
  home.homeDirectory = "/home/flowcheer";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
	pkgs.yt-dlp
	pkgs.spicetify-cli
	pkgs.btop
	pkgs.prismlauncher
	(pkgs.discord.override {
  		withVencord = true;
	})
	pkgs.doomseeker
	pkgs.godot-mono
	pkgs.blender
	pkgs.krita
	pkgs.spotify
	pkgs.aseprite
	pkgs.clipse
  ];

  # dark mode settings
  gtk = {
	enable = true;
	theme = {
		name = "Adwaita-dark";
		package = pkgs.gnome-themes-extra;
	};
  };

  qt = {
	enable = true;
	#platformTheme = "qt5ct";
	#style = "adwaita-dark";
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/flowcheer/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "zeditor";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
