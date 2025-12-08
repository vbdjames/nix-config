{
  programs.thunderbird = {
    enable = true;
    profiles = {
      default = {
        isDefault = true;
      };
    };
  };

  accounts.email.accounts = {
    "doug@dwjames.org" = {
      primary = true;
      address = "doug@dwjames.org";
      flavor = "fastmail.com";
      imap.host = "imap.fastmail.com";
      realName = "Doug James";
      smtp.host = "smtp.fastmail.com";
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
      userName = "doug@dwjames.org";
    };
    "vbdjames@gmail.com" = {
      address = "vbdjames@gmail.com";
      flavor = "gmail.com";
      imap.host = "imap.gmail.com";
      imap.port = 993;
      realName = "Doug James";
      smtp.host = "smtp.gmail.com";
      smtp.port = 465;
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
    };
    "doug.james@customviewbook.com" = {
      address = "doug.james@customviewbook.com";
      flavor = "gmail.com";
      imap.host = "imap.gmail.com";
      imap.port = 993;
      realName = "Doug James";
      smtp.host = "smtp.gmail.com";
      smtp.port = 465;
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
    };
  };

}