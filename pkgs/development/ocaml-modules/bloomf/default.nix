{ lib, buildDunePackage, fetchFromGitHub, alcotest, bitv }:
buildDunePackage rec {
  pname = "bloomf";
  version = "0.2.0";

  minimumOcamlVersion = "4.03";

  useDune2 = true;

  src = fetchFromGitHub {
    owner = "mirage";
    repo = "bloomf";
    rev = "v${version}";
    sha256 = "sha256-WAW+q70QTmhv4DxypDHA93S2XMtkUfDXn6mAT7IuB0s=";
  };

  buildInputs = [
    alcotest
  ];

  propagatedBuildInputs = [
    bitv
  ];
}
