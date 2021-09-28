{ lib
, buildDunePackage
, fetchFromGitHub
# Build dependencies
, ansiterminal
, grain_dypgen
, easy_logging_yojson
, menhir
, ocamlgraph
, ppx_base
, ppx_deriving
, yojson
# Test dependencies
, alcotest
, uucp
}:
buildDunePackage rec {
  pname = "pfff-unstable";
  version = "2021-09-30";

  src = fetchFromGitHub {
    owner = "returntocorp";
    repo = "pfff";
    rev = "174c4b07d5556929f4bb44fbe9e5766da25f6c44";
    sha256 = "sha256-1GcPJDOxtnyqru7NORPL/eNTMCsFuMg1GVCcpYzMIUE=";
  };

  useDune2 = true;

  # Make sure the configure hooks are run
  configurePhase = ''
    runHook preConfigure
    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild
    dune build --release ''${enableParallelBuilding:+-j $NIX_BUILD_CORES}
    runHook postBuild
  '';

  checkPhase = ''
    runHook preCheck
    dune runtest ''${enableParallelBuilding:+-j $NIX_BUILD_CORES}
    runHook postCheck
  '';

  installPhase = ''
    runHook preInstall
    dune install --prefix $out --libdir $OCAMLFIND_DESTDIR
    runHook postInstall
  '';

  buildInputs = [
    grain_dypgen
    menhir
  ];

  propagatedBuildInputs = [
    alcotest
    ansiterminal
    easy_logging_yojson
    ocamlgraph
    ppx_base
    ppx_deriving
    uucp
    yojson
  ];

  meta = with lib; {
    description = ''
      An OCaml API to write static analysis, dynamic analysis, code
      visualizations, code navigations, or style-preserving source-to-source
      transformations.
    '';
    homepage = "https://github.com/returntocorp/pfff";
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [ ambroisie ];
  };
}
