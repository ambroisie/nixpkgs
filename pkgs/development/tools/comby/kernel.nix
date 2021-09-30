{ callPackage }:
let
  mkCombyPackage = callPackage ./mk-comby-package.nix { };
in
mkCombyPackage { pname = "comby-kernel"; }
