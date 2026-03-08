{...}: {
  systemd.services."kanata-default".serviceConfig.SupplementaryGroups = [ "input" "uinput" ];
  services.kanata = {
    enable = true;
    keyboards = {
      default = {
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
            w r
            caps a s d f j k l ;
            spc
            ret
            )

          (deflayer base
                    w r
                    @caps a s d f j k l ;
                    spc
                    ret
                    )

          (deflayer specials
                    C-w C-r
                    _ S-8 S-9 RA-7 RA-0 RA-8 RA-9 C-l @ctl
                    M-d
                    M-ret
                    )

          (defalias
            caps (tap-hold 75 125 esc (layer-toggle specials))
            ctl  (multi lctl (layer-while-held base))
            )
        '';
      };
    };
  };
}
