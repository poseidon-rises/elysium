{ config, lib, ... }:

let
  cfg = config.elysium.disko.zfs-layout;
in
{
  options.elysium.disko.zfs-layout = {
    enable = lib.mkEnableOption "Disko ZFS layout";

    disks = lib.mkOption {
      default = {
        "root" = {
          device = "/dev/nvme0n1";
          hasBoot = true;
        };
      };

      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            device = lib.mkOption {
              default = "/dev/nvme0n1";
              example = "/dev/sda";
              type = lib.types.str;
            };

            hasBoot = lib.mkOption {
              default = false;
              example = true;
              type = lib.types.bool;
            };

            zpool = lib.mkOption {
              default = "zroot";
              example = "tank";
              type = lib.types.str;
            };
          };
        }
      );
    };
  };

  config = {
    disko.devices = lib.mkIf cfg.enable {
      disk = lib.mkAttrs (
        lib.mapAttrsToList (diskName: disk: {
          "${diskName}" = {
            type = "disk";
            inherit (disk) device;
            content = {
              type = "gpt";
              partitions = {
                ESP = lib.mkIf disk.hasBoot {
                  size = "512MiB";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "umask=0077" ];
                  };
                };

                zfs = {
                  size = "100%";
                  content = {
                    type = "zfs";
                    zpool = disk.zpool;
                  };
                };
              };
            };
          };
        }) cfg.disks
      );

      zpool.zroot = {
        type = "zpool";

        rootFsOptions = {
          mountpoint = "none";
          compression = "lz4";
          acltype = "posixacl";
          xattr = "sa";
          "com.sun:auto-snapshot" = "false";
        };

        options.ashift = "12";

        datasets = {
          "root" = {
            type = "zfs_fs";

            options = {
              encryption = "passphrase";
              keyformat = "prompt";
              keylocation = "prompt";
            };

            mountpoint = "/";
          };

          "root/nix" = {
            type = "zfs_fs";
            options.mountpoint = "/nix";
            mountpoint = "/nix";
            "com.sun:auto-snapshot" = "false";
          };

          "root/home" = {
            type = "zfs_fs";
            options.mountpoint = "/home";
            mountpoint = "/home";
            "com.sun:auto-snapshot" = "true";
          };

          "root/swap" = {
            type = "zfs_volume";
            size = "16GB";
            content = {
              type = "swap";
            };
            options = {
              volblocksize = "4096";
              compression = "zle";
              logbias = "throughput";
              sync = "always";
              primarycache = "metadata";
              secondarycache = "none";
              "com.sun:auto-snapshot" = "false";
            };
          };
        };
      };
    };
    assertions = [
      {
        assertion = lib.count (disk: disk.hasBoot) (lib.attrValues cfg.disks) == 1;
        message = "Only one disk may have a boot partition";
      }
    ];
  };
}
