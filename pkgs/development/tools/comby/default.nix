{ ocamlPackages
, callPackage
, zlib
, pkg-config
, gmp
, libev
, autoconf
, sqlite
, stdenv
}:
let
  mkCombyPackage = callPackage ./mk-comby-package.nix { };
in
mkCombyPackage {
  pname = "comby";

  # tests have to be removed before building otherwise installPhase will fail
  # cli tests expect a path to the built binary
  preBuild = ''
    substituteInPlace test/common/dune \
      --replace "test_cli_list" "" \
      --replace "test_cli_helper" "" \
      --replace "test_cli" ""
    rm test/common/{test_cli_list,test_cli_helper,test_cli}.ml
  '';

  extraBuildInputs = [
    zlib
    gmp
    libev
    sqlite
    ocamlPackages.shell # This input must appear before `parany` or any other input that propagates `ocamlnet`
    ocamlPackages.lwt
    ocamlPackages.patience_diff
    ocamlPackages.toml
    ocamlPackages.cohttp-lwt-unix
    ocamlPackages.opium
    ocamlPackages.textutils
    ocamlPackages.jst-config
    ocamlPackages.parany
    ocamlPackages.conduit-lwt-unix
    ocamlPackages.lwt_react
    ocamlPackages.tls
    ocamlPackages.comby-kernel
    ocamlPackages.comby-semantic
  ] ++ (if !stdenv.isAarch32 && !stdenv.isAarch64 then
    [ ocamlPackages.hack_parallel ]
  else
    [ ]);

  extraNativeInputs = [
    autoconf
    pkg-config
    ocamlPackages.ppx_jane
    ocamlPackages.ppx_expect
    ocamlPackages.dune-configurator
  ];

}
