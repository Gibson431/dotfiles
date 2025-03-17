{ pkgs, ... }: {
  environment.systemPackages = (with pkgs; [ gqrx rtl-sdr libusb1 ]);
  hardware.rtl-sdr.enable = true;

  boot.kernelParams = [ "modprobe.blacklist=dvb_usb_rtl28xxu" ];

  services.udev.packages = [ pkgs.rtl-sdr ];
  users.users.main.extraGroups = [ "plugdev" ];
}
