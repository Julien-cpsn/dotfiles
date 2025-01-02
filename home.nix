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
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Virtualization
    qemu
    docker

    # Utils
    fd
    atac
    vim
    hyperfine
    gping
    tldr
    neofetch
    websocketd
    websocat
    broot

    # Programming languages
    rustup
    php82
    python3
    nodejs_22
    jdk
    zig
    c3c
    gleam
    typst

    # C
    gcc
    cmake
    ninja
    cosmopolitan
    cosmocc

    # PHP
    php82Packages.composer

    # Python
    uv
    python312Packages.meson
    
    # Javascript
    bun

    # Terminal
    tmux

    # Libs
    nasm
    sqlite
    pkg-config
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

  #Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      nix-update = "nix-channel --update";
      nix-shell = "nix-shell --run $SHELL";
      nix-create-shell = "cp /home/julien/Programmation/nix/dotfiles/shell.nix .";
      home-build = "home-manager build";
      home-switch = "home-manager switch";
      home-update = "home-build && home-switch";
      home-diff = "diff ~/.config/home-manager/home.nix ~/Programmation/nix/dotfiles/home.nix";

      freespace = "sudo du -sh ./*";
      ls = "ls --color=auto";
      fls = "ls -lhrtaX --group-directories-first";
    };

    initExtra = ''
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey "^[[3~" delete-char
      bindkey "^[[H" beginning-of-line
      bindkey "^[[F" end-of-line
      bindkey "^[[24;2~" end-of-line

      setopt globstarshort

      # This script was automatically generated by the broot program
      # More information can be found in https://github.com/Canop/broot
      # This function starts broot and executes the command
      # it produces, if any.
      # It's needed because some shell commands, like `cd`,
      # have no useful effect if executed in a subshell.
      function br {
        local cmd cmd_file code
        cmd_file=$(mktemp)
        if broot --outcmd "$cmd_file" "$@"; then
          cmd=$(<"$cmd_file")
          command rm -f "$cmd_file"
          eval "$cmd"
        else
          code=$?
          command rm -f "$cmd_file"
          return "$code"
        fi
      }
    '';

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

      scan_timeout = 10;
      command_timeout = 100;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  targets.genericLinux.enable = true;
}
