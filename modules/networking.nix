{
  config,
  ...
}:
{
  sops.secrets.wifi-env.group = "networkmanager";

  networking = {
    networkmanager = {
      enable = true;
      wifi = {
        backend = "wpa_supplicant";
        powersave = true;
      };

      ensureProfiles = {
        environmentFiles = [
          config.sops.secrets.wifi-env.path
        ];
        profiles = {
          fiddlestick = {
            connection = {
              id = "509 Fiddlestick";
              type = "wifi";
            };
            wifi = {
              mode = "infrastructure";
              security = "wpa-psk"; # WPA2 Personal
              ssid = "509 Fiddlestick";
            };
            wifi-security = {
              auth-alg = "open";
              key-mgmt = "wpa-psk";
              psk = "$FIDDLESTICK_WIFI_PASSWORD";
            };
          };
          antech = {
            connection = {
              id = "Antech Guest";
              type = "wifi";
            };
            wifi = {
              mode = "infrastructure";
              security = "wpa-psk"; # WPA2 Personal
              ssid = "Guest";
            };
            wifi-security = {
              auth-alg = "open";
              key-mgmt = "wpa-psk";
              psk = "$ANTECH_WIFI_PASSWORD";
            };
          };
          redwing = {
            connection = {
              id = "Meagan & Michael";
              type = "wifi";
            };
            wifi = {
              mode = "infrastructure";
              security = "wpa-psk";
              ssid = "FBI Sniffer";
            };
            wifi-security = {
              auth-alg = "open";
              key-mgmt = "wpa-psk";
              psk = "$REDWING_WIFI_PASSWORD";
            };
          };
        };
      };
    };
  };
}
