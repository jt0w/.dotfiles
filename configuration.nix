# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  overlays,
  config,
  lib,
  ...
}: {
  nix.package = pkgs.lixPackageSets.stable.lix;
  imports = [
    ./hardware-configuration.nix
    ./modules/nixos/dwl
    ./modules/nixos/greetd
    ./modules/shared
    ./modules/nixos/nivida/nvidia.nix
    ./modules/nixos/keyd
  ];
  nixpkgs.overlays = overlays;
  #bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true; # blueman

  services.xserver = {
    enable = true;
    resolutions = [
      {
        x = 1920;
        y = 1080;
      }
    ];
  };
  environment.shells = with pkgs; [fish];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  environment.systemPackages = [pkgs.man-pages pkgs.man-pages-posix pkgs.xorg.xinit];
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
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  boot.consoleLogLevel = 0;
  hardware.alsa.enable = true;

  # kernelPackages
  boot.kernelPackages = pkgs.linuxPackages;
  hardware.enableAllFirmware = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.wantedBy = lib.mkForce [];

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
    extraGroups = ["networkmanager" "wheel" "libvirtd" "docker" "audio" "wireshark" "storage"];
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
    enable = true;

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
  programs.obs-studio.enable = true;
  programs.gamemode.enable = true;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system. Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["lukas"];
  services.hardware.openrgb.enable = true;
  programs.coolercontrol = {
    enable = true;
    # nvidiaSupport = true;
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
  '';
  security.polkit.enable = true;

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
