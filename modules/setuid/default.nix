{ pkgs, ... }:
{
  security.wrappers = {
    cbmem = {
      setuid = true;
      owner = "root";
      group = "root";
      source = "${pkgs.cbmem}/bin/cbmem";
    };
    ectool = {
      setuid = true;
      owner = "root";
      group = "root";
      source = "${pkgs.cros-ectool}/bin/ectool";
    };
  };
}
