{
  description = "Personal Development Shells";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    templates = {
      python = {
        path = ./python;
        description = "Simple Python Shell";
        welcomeText = ''
        '';
      };
      rust = {
        path = ./rust;
        description = "Simple Rust Shell";
        welcomeText = ''
        '';
      };
      js = {
        path = ./jsts;
        description = "Simple JavaScript (ts) Shell";
        welcomeText = ''
        '';
      };
    };
  };
}
