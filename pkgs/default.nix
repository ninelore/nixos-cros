{ pkgs, ... }:
with pkgs;
{
  alsa-ucm-conf-cros = callPackage ./alsa-ucm-conf-cros { };
  cros-ectool = callPackage ./cros-ectool { };
  #cros-gsctool = callPackage ./cros-gsctool { }; # TODO: Broken
}
