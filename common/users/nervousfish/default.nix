{ pkgs, ... }:

{
  users.users.nervousfish = {
    isNormalUser = true;
    description = "nervous-fish";
    extraGroups = [ "audio" "networkmanager" "wheel" "greeter" "libvirtd" "docker" "wireshark" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
    openssh = {
      authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWWAAby0IBnBF27+KLGEu0e9HSR308f6v3Nc/nWOhmZ4FnXjqk+hSCCDZYhqSkfip/VWQcLt2XHK0rOpxDQH9zIYDkIrOs8udD4+Shx32+unQS7CkEMXtmi5DqLfQURgFqtdNT0boVPiIujgpIHK2lHLHZuIIRIX9/2iq6eX6iTHKEYEMZUvB6exJJv7QsyOIr3DavrEhjWhpS3BOWtFsJuvw/OfnUhE+01fSgD/rppUSgMK5Hapnvv/h3MVslm+Q4I6oKxucQrf2p8woHWve5qpUaeFWDD28TdLSFYtpbc3uSpbkM9ZWuCd/WGFGIZd42QecdoAiyowVCtg9wqjmqHnjAfoa++LYBAnhWLoZIxSmrMEuSgjnbP8RvYdCcP16iCQ6D3RC8z5Cdevk+9l77GtxVYENOv5gtBymrzvEgPZgVXRYmHUZsmxF9Urp4U6eLpaUEzl60Ki65P9aYQ+xFQgaDWt5LQKBvKQe+X+n1sg8Sp//ILfSwqwoXU3C/o1c="
      ];
    };
  };
}
