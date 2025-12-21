{
  config,
  ...
}:
{
  sops.secrets.syncthing-cert = { };
  sops.secrets.syncthing-key = { };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    cert = config.sops.secrets.syncthing-cert.path;
    key = config.sops.secrets.syncthing-key.path;
    user = "djames";
    configDir = "/home/djames/.config/syncthing";
    settings = {
      devices = {
        "nas" = {
          id = "XMN3JYM-PDNPPZG-FCYN3VX-C7J652A-7HQR6CH-BZTKU2I-5K4IV35-DIWVHA4";
        };
        "sophie" = {
          id = "PTO5CRF-CM3XYCG-QCQ6ZSK-XHMUEEJ-FASAEDA-EO7Y3WF-GW6F6HS-U375WQK";
        };
      };
      folders = {
        "code" = {
          id = "code";
          path = "/home/djames/code";
          devices = [
            "nas"
            "sophie"
          ];
        };
        "documents" = {
          id = "documents";
          path = "/home/djames/documents";
          devices = [
            "nas"
            "sophie"
          ];
        };
        "notes" = {
          id = "notes";
          path = "/home/djames/notes";
          devices = [
            "nas"
            "sophie"
          ];
        };
        "pictures" = {
          id = "pictures";
          path = "/home/djames/pictures";
          devices = [
            "nas"
            "sophie"
          ];
        };
        "projects" = {
          id = "projects";
          path = "/home/djames/projects";
          devices = [
            "nas"
            "sophie"
          ];
        };
        "videos" = {
          id = "videos";
          path = "/home/djames/videos";
          devices = [
            "nas"
            "sophie"
          ];
        };
        "work" = {
          id = "work";
          path = "/home/djames/work";
          devices = [
            "nas"
            "sophie"
          ];
        };
      };
    };
  };

}