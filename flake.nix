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
      default = {
        path = ./default;
        description = "Generic Flake";
        welcomeText = ''
        '';
      };
      python = {
        path = ./python;
        description = "Simple Python Flake";
        welcomeText = ''
        '';
      };
      rust = {
        path = ./rust;
        description = "Simple Rust Flake";
        welcomeText = ''
        '';
      };
      java = {
        path = ./java;
        description = "Simple Java Flake";
        welcomeText = ''
          OpenJDK 21
        '';
      };
    };
  };
}
