{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "julien";
  home.homeDirectory = "/home/julien";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # Applications
    pkgs.google-chrome
    pkgs.spotify

    # Virtualization
    pkgs.docker

    # Utils
    #pkgs.git
    pkgs.curl
    pkgs.fd
    pkgs.atac
    pkgs.vim
    pkgs.hyperfine
    pkgs.gping
    pkgs.tldr

    # Programming languages
    pkgs.rustup
    pkgs.php
    pkgs.python3
    pkgs.nodejs_22
    pkgs.zig
    pkgs.c3c
    pkgs.gleam
    pkgs.typst

    # C
    pkgs.gcc
    pkgs.cmake
    pkgs.ninja

    # PHP
    pkgs.php82Packages.composer

    # Python
    pkgs.uv

    # Libs
    pkgs.nasm

    # Gnome
    #pkgs.dconf
    #pkgs.gnomeExtensions.dash-to-panel
    #pkgs.gnomeExtensions.appindicator
    #pkgs.gnomeExtensions.emoji-copy
  ];

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
  #  /etc/profiles/per-user/julien/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      nix-update = "nix-channel --update";
      home-build = "home-manager build";
      home-switch = "home-manager switch";
      home-update = "home-build && home-switch";

      freespace = "sudo du -sh ./*";
      ls = "ls --color=auto";
      fls = "ls -lhrtaX --group-directories-first";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

  };

  programs.starship = {
    enable = true;
    # Configuration écrite dans ~/.config/starship.toml
    settings = {
      format = ''
╭─ $username$hostname$directory$git_branch$git_commit$git_state$docker_context$package$c$cmake$lua$nodejs$php$python$rust$typst$zig$nix_shell$memory_usage$env_var$custom$sudo$cmd_duration$jobs$time$status$os$container
╰─\$ '';

      add_newline = true;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };
}
