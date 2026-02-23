{
  pkgs,
  inputs,
  ghostty,
  system,
  ...
}:
{
  # nixpkgs
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = true;
  };
  # fonts
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    #fonts
    fira-math
    cm_unicode

    # ESSENTIAL
    woomer
    # edb
    gdb
    gf
    xxd
    fasm
    gnumake
    gcc
    cloc

    util-linux
    font-awesome
    corefonts
    fyi

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
    discordo
    appimage-run
    pokeget-rs
    prismlauncher

    libresprite
    krita
    inkscape
    penpot-desktop
    mypaint
    mypaint-brushes
    mypaint-brushes1
    libsForQt5.qt5.qtwayland
    glfw

    htop
    git-extras
    gh
    killall

    qpwgraph
    pulsemixer
    bluez
    swww

    #dev
    just
    fasm

    #extra
    bitwarden-desktop
    openssl
    bat
    ripgrep
    rhythmbox
    ffmpeg
    mangohud
    protonmail-desktop

    # my pkgs
    inputs.kix.packages.${system}.default

    swayimg
    # libreoffice
    ferdium
    sshfs
    qmk

    ghostty.packages.${system}.default

    # games
    # lutris
    # daggerfall-unity

    # music
    ardour
    audacity
    bespokesynth
    audacious
    audacious-plugins
    # muffon

    # bottles

    milkytracker

    musescore
    muse-sounds-manager

    distrho-ports
    # carla
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
    eq10q
    # infamousPlugins
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

    element-desktop
  ];

  stylix.targets.firefox.profileNames = [ "default" ];
  programs.firefox = {
    enable = true;
    arkenfox = {
      enable = true;
      version = "140.0";
    };
    profiles.default = {
      settings = {
        "general.autoScroll" = true;
        "browser.download.panel.shown" = true;
        "browser.toolbars.bookmarks.visibility" = "newtab";
        "browser.compactmode.show" = true;
        "widget.non-native-theme.scrollbar.style" = 3;
        "browser.tabs.closeWindowWithLastTab" = false;
        "browser.tabs.tabmanager.enabled" = true;
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
      };
      userChrome = ''
        /**
        * Hide sidebar-panel-header (sidebar.revamp: true)
        */
        #sidebar-panel-header {
          display: none;
        }

        /**
        * Dynamic styles
        *
        * Choose when styles below will be activated (comment/uncomment line)
        * - When Sidebery set title preface "."
        * - When Sidebery sidebar is active
        */
        /* #main-window[titlepreface="."] {* /
        /* #main-window:has(#sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"][checked="true"]) { */

          /* Hide horizontal native tabs toolbar */
          #TabsToolbar > * {
            display: none !important;
          }

          /* Hide top window border */
          #nav-bar {
            border-color: transparent !important;
          }

          /* Hide new Firefox sidebar, restyle addon's sidebar */
          #sidebar-main, #sidebar-launcher-splitter {
            display: none !important;
          }
          #sidebar-box {
            padding: 0 !important;
          }
          #sidebar-box #sidebar {
            box-shadow: none !important;
            border: none !important;
            outline: none !important;
            border-radius: 0 !important;
          }
          #sidebar-splitter {
            --splitter-width: 3px !important;
            min-width: var(--splitter-width) !important;
            width: var(--splitter-width) !important;
            padding: 0 !important;
            margin: 0 calc(-1*var(--splitter-width) + 1px) 0 0 !important;
            border: 0 !important;
            opacity: 0 !important;
          }

          /* Update background color of the #browser area (it's visible near the
          rounded corner of the web page) so it blends with sidebery color with 
          vertical nav-bar. */
          /* #browser {
            background-color: var(--lwt-accent-color) !important;
            background-image: none !important;
          } */

          /* Hide sidebar header (sidebar.revamp: false) */
          #sidebar-header {
            display: none !important;
          }

          /* Uncomment the block below to show window buttons in Firefox nav-bar 
          (maybe, I didn't test it on non-linux-tiled-wm env) */
          /* #nav-bar > .titlebar-buttonbox-container,
          #nav-bar > .titlebar-buttonbox-container > .titlebar-buttonbox {
            display: flex !important;
          } */

          /* Uncomment one of the lines below if you need space near window buttons */
          /* #nav-bar > .titlebar-spacer[type="pre-tabs"] { display: flex !important; } */
          /* #nav-bar > .titlebar-spacer[type="post-tabs"] { display: flex !important; } */
        /* } */
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
            definedAliases = [ "@nix" ];
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

            definedAliases = [ "@gh" ];
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

            definedAliases = [ "@ghu" ];
          };
        };
        force = true;
      };
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          sponsorblock
          darkreader
          vimium
          ublock-origin
          unpaywall
          untrap-for-youtube
          return-youtube-dislikes
          sidebery
        ];
      };
      arkenfox = {
        enable = true;
        "0000".enable = true;
        "0100".enable = true;
        "0200".enable = true;
        "0300".enable = true;
        "0400".enable = false;
        "0600".enable = false;
        "0700".enable = true;
        "0800".enable = true;
        "0900".enable = true;
        "1000".enable = true;
        "1200".enable = true;
        "1700".enable = true;
        "2600".enable = true;
        "2700".enable = true;
      };
    };
  };
  programs.thunderbird = {
    enable = true;
    profiles = { };
  };
  programs.zathura.enable = true;
  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = "Papirus-Dark";
  };
  services.cliphist.enable = true;
  programs.fastfetch.enable = true;
  programs.radio-active.enable = true;
  services.amberol.enable = true;
  programs.mpv.enable = true;
  programs.vesktop.enable = true;
}
