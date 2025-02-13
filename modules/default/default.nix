{ pkgs, ... }:
{
  # TODO: wireplumber headroom
  environment = {
    sessionVariables.ALSA_CONFIG_UCM2 = "${pkgs.alsa-ucm-conf-cros}/share/alsa/ucm2";
    systemPackages = with pkgs; [
      sof-firmware
    ];
    # TODO: No handling for Nocturne, Atlas, Eve, Sarien and Arcada keyboards yet
    etc = {
      "libinput/cros.quirks".text = ''
        [keyd virtual keyboard]
        MatchName=keyd virtual keyboard
        AttrKeyboardIntegration=internal
        ModelTabletModeNoSuspend=1
      '';
    };
  };

  security.tpm2.enable = false;
  hardware.sensor.iio.enable = true;
  boot.initrd.systemd.tpm2.enable = false;

  boot.kernelParams = [ "iomem=relaxed" ];

  services = {
    keyd.enable = true;
    libinput.enable = true;
  };
}
