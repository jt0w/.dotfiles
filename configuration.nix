# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  overlays,
  config,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/shared
    ./modules/nixos/nivida/nvidia.nix
    ./modules/nixos/kanata
  ];
  nixpkgs.overlays = overlays;
  #bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true; # blueman

  programs.sway.enable = true;

  services.xserver = {
    enable = true;
    resolutions = [
      {
        x = 1920;
        y = 1080;
      }
    ];
  };

  environment.shells = with pkgs; [bash];
  users.defaultUserShell = pkgs.bash;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  environment.systemPackages = [
    pkgs.man-pages
    pkgs.man-pages-posix
    pkgs.xorg.xinit
  ];
  documentation.dev.enable = true;
  documentation.man = {
    enable = true;
    generateCaches = true;
  };

  #sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = lib.mkForce true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.pipewire.wireplumber.enable = true;
  environment.sessionVariables.ALSA_AUDIO_OUT = "pipewire";
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  boot.consoleLogLevel = 0;

  # kernelPackages
  boot.kernelPackages = pkgs.linuxPackages;
  hardware.enableAllFirmware = true;
  boot.kernelModules = ["uinput"];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.wantedBy = lib.mkForce [];
  networking.nameservers = [
    "192.168.178.1"
    "8.8.8.8"
    "1.1.1.1"
  ];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NMERIC = "de_DE.UTF-8";
    #    LC_PAPER = "de_DE.UTF-8";
    #    LC_TELEPHONE = "de_DE.UTF-8";
    #    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lukas = {
    isNormalUser = true;
    description = "Lukas";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "docker"
      "audio"
      "wireshark"
      "storage"
      "uinput"
      "lp"
      "scanner"
    ];
    packages = [];
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.enable = true;
  systemd.services.docker = {
    wantedBy = lib.mkForce ["graphical.target"];
    after = lib.mkForce ["graphical.target"];
  };
  virtualisation.libvirtd = {
    enable = false;

    qemu = {
      # ovmf.enable = true;
      # ovmf.packages = [pkgs.OVMFFull.fd];
      swtpm.enable = true;
    };
  };
  programs.virt-manager.enable = true;
  environment.etc = {
    "ovmf/edk2-x86_64-secure-code.fd" = {
      source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
    };

    "ovmf/edk2-i386-vars.fd" = {
      source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-i386-vars.fd";
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  programs.steam.enable = true;
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  programs.obs-studio.enable = true;
  # Printing
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.sane.enable = true;
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };

  programs.thunar.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
  };

  services.flatpak.enable = true;

  hardware.opentabletdriver.enable = true;
  hardware.keyboard.qmk.enable = true;
  services.udev.packages = with pkgs; [qmk-udev-rules];

  musnix.enable = true; # music
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
    dumpcap.enable = true;
    usbmon.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall.extraCommands = ''
    iptables -I nixos-fw -s 172.16.0.0/12 -p tcp --dport 11434 -j nixos-fw-accept
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system. Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.trusted-users = ["lukas"];
  services.hardware.openrgb.enable = true;
  programs.coolercontrol = {
    enable = true;
    # nvidiaSupport = true;
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
    KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput", GROUP="input", MODE="0660"
  '';
  security.polkit.enable = true;

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # Sway doesn't ship a file chooser portal, so add gtk for that
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.sway = {
      default = ["gtk"];
      "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.Screenshot" = "wlr";
    };
    config.screencast = {
      chooser_type = "simple";
      chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
    };
  };
  systemd.user.services.xdg-desktop-portal-wlr.path = [pkgs.fuzzel];

  programs.kdeconnect.enable = true;

  services.ollama = {
    enable = true;
    host = "0.0.0.0";
  };
}
