{...}: {
  systemd.services."kanata-default".serviceConfig.SupplementaryGroups = [
    "input"
    "uinput"
  ];
  services.kanata = {
    enable = true;
    keyboards = {
      default = {
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
           caps
          )

          (deflayer base
           @caps
          )

          (defalias
           caps (tap-hold-press 75 125 esc lctl)
          )
        '';
      };
    };
  };
}
