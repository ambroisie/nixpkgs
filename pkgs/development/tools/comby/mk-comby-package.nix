{ lib, fetchFromGitHub, cacert, ocamlPackages }:
{ pname, extraBuildInputs ? [ ], extraNativeInputs ? [ ], preBuild ? "" }:
ocamlPackages.buildDunePackage rec {
  inherit pname preBuild;
  version = "1.7.0";
  useDune2 = true;
  minimumOcamlVersion = "4.08.1";
  doCheck = true;

  src = fetchFromGitHub {
    owner = "comby-tools";
    repo = "comby";
    rev = version;
    sha256 = "sha256-Y2RcYvJOSqppmxxG8IZ5GlFkXCOIQU+1jJZ6j+PBHC4";
  };

  nativeBuildInputs = [
    ocamlPackages.ppx_deriving
    ocamlPackages.ppx_deriving_yojson
    ocamlPackages.ppx_sexp_conv
    ocamlPackages.ppx_sexp_message
  ] ++ extraNativeInputs;

  buildInputs = [
    ocamlPackages.ocaml_pcre
    ocamlPackages.mparser
  ] ++ extraBuildInputs;

  propagatedBuildInputs = [
    ocamlPackages.angstrom
    ocamlPackages.core
    ocamlPackages.mparser-pcre
  ];

  checkInputs = [ cacert ];

  meta = {
    description = "Tool for searching and changing code structure";
    license = lib.licenses.asl20;
    homepage = "https://comby.dev";
  };
}
