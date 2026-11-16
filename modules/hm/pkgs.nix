{
  pkgs,
  inputs,
  system,
  ...
}: {
  # nixpkgs
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = true;
	permittedInsecurePackages = [
      "firefox-esr-140-bin-unwrapped-140.17.0esr"
	];
  };
  # fonts
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    #fonts
    fira-math
    cm_unicode

    # ESSENTIAL

    # edb
    gdb
    gf
    xxd
    fasm
    gnumake
    gcc
    cloc
    unzip

    util-linux
    font-awesome
    corefonts
    fyi
    openvpn

    sl
    cowsay
    nitch
    inetutils
    # deadbeef
    alejandra
    fortune
    dwt1-shell-color-scripts
    kdePackages.kclock
    calc
    fzf
    typioca
    watchexec
    man
    wget
    file
    appimage-run
    pokeget-rs
    prismlauncher
    blockbench

    libresprite
    krita
    # gimp
    # inkscape
    qt5.qtwayland
    glfw

    htop
    git-extras
    gh
    killall

    kdePackages.skanlite

    qpwgraph
    pulsemixer
    bluez
    awww

    kicad
    (python313.withPackages (ps: [ps.wxpython]))
	zotero
    #dev
    just
    fasm

    #extra
    # bitwarden-desktop
    openssl
    bat
    ripgrep
    ffmpeg
    digikam

    # my pkgs
    inputs.kix.packages.${system}.default

    swayimg
    libreoffice
    sshfs
    qmk

    # games
    # lutris
    # daggerfall-unity
    openttd
    runelite
    # mindustry-wayland
    # zeroad
    beyond-all-reason
    freeorion
    # endless-sky

    # music
    ardour
    # mixxx
    audacity
    bespokesynth
    audacious
    audacious-plugins
    # muffon

    # bottles

    musescore
    muse-sounds-manager

    guitarix
    gxplugins-lv2

    distrho-ports
    carla
    helm
    odin2
    tunefish
    redux
    # surge
    # surge-XT
    lsp-plugins
    dexed
    drumkv1
    samplv1
    synthv1
    drumgizmo
    x42-plugins
    x42-avldrums
    x42-gmsynth
    geonkick
    calf
    fluidsynth
    zynaddsubfx
    cardinal
    # artyFX
    bchoppr
    dragonfly-reverb
    # eq10q
    infamousPlugins
    oxefmsynth
    sfizz
    chow-kick
    chow-phaser
    chow-centaur
    chow-tape-model
    swh_lv2
    airwindows
    wolf-shaper
    tap-plugins
    aether-lv2
    ninjas2
    stochas
    fire
    bslizr

    linuxsampler
    qsampler
  ];

  stylix.targets.librewolf.profileNames = ["default"];
  programs.librewolf = {
    enable = true;
    profiles.default = {
      settings = {
        "general.autoScroll" = true;
        "browser.download.panel.shown" = true;
        "browser.toolbars.bookmarks.visibility" = "newtab";
        "browser.compactmode.show" = true;
        "widget.non-native-theme.scrollbar.style" = 3;
        "browser.tabs.closeWindowWithLastTab" = false;
        "mousewheel.default.delta_multiplier_y" = 300;

        "browser.vpn_promo.enabled" = false;
        "extensions.pocket.enabled" = false;

        "toolkit.telemetry.*" = false;
        "datareporting.usage.uploadEnabled" = false;
        "browser.dataFeatureRecommendations.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.recommendationprovider" = false;
        "browser.newtabpage.activity-stream.feeds.recommendationproviderswitcher" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;

        "network.http.rcwn.enabled" = false;
        "general.smoothScroll.msdPhysics.enabled" = true;

        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "sidebar.revamp" = false;
      };
      userChrome = ''
        #TabsToolbar			{ display: none				!important;	}
        #sidebar-header      	{ display: none				!important;	}
        #sidebar-box			{ padding-inline-start: 0px !important;	}

              * {
          border-radius: 0px !important;
        }
      '';

      search = {
        default = "duckduckgo";
        engines = {
          "unduck" = {
            urls = [
              {
                template = "https://unduck.link";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "Nix" = {
            urls = [
              {
                template = "https://mynixos.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nix"];
          };
          "Github" = {
            urls = [
              {
                template = "https://github.com/search";
                params = [
                  {
                    name = "type";
                    value = "repositories";
                  }
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            definedAliases = ["@gh"];
          };
          "Github User" = {
            urls = [
              {
                template = "https://github.com/search";
                params = [
                  {
                    name = "type";
                    value = "users";
                  }
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            definedAliases = ["@ghu"];
          };
        };
        force = true;
      };
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          stylus
          bitwarden
          sponsorblock
          darkreader
          vimium
          ublock-origin
          unpaywall
          return-youtube-dislikes
          sidebery
		  zotero-connector
        ];
      };
    };
  };
  programs.thunderbird = {
    enable = true;
    profiles = {};
  };
  programs.sioyek = {
    enable = true;
    package = pkgs.symlinkJoin {
      name = "sioyek";
      paths = [pkgs.sioyek];
      buildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/sioyek \
        --set QT_QPA_PLATFORM xcb
      '';
    };
  };
  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = "Papirus-Dark";
  };
  services.cliphist.enable = true;
  programs.fastfetch.enable = true;
  programs.radio-active.enable = true;
  services.amberol.enable = true;
  programs.mpv.enable = true;
  # programs.vesktop.enable = true;
  # programs.irssi.enable = true;
}
