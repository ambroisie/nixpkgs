{ lib
, stdenv
, fetchFromGitHub
, comby
, dune_2
, ocaml
, ocamlPackages
, pkg-config
, tree-sitter
}:
stdenv.mkDerivation rec {
  pname = "semgrep";
  version = "0.66.0";

  src = fetchFromGitHub {
    owner = "returntocorp";
    repo = "semgrep";
    rev = "v${version}";
    sha256 = "sha256-y8LLEL/Np3WoLS3vPhB79Mz8Wfg1nafQuMuq/WmtAdc=";
  };

  postPatch =
  let
    versionScript = ''
      cat <<EOF
      (* generated at build time by nix *)
      (*
        semgrep-core version.
      *)
      let version = "${version}"
      EOF
    '';
  in
  ''
    # Remove need to read version from git
    echo '${versionScript}' > semgrep-core/scripts/make-version

    patchShebangs scripts
    patchShebangs semgrep-core/scripts
  '';

  buildInputs = [
    dune_2
    ocaml
    ocamlPackages.atdgen
    ocamlPackages.bloomf
    ocamlPackages.comby-kernel
    ocamlPackages.findlib
    ocamlPackages.grain_dypgen
    ocamlPackages.lsp
    ocamlPackages.ocaml_pcre
    ocamlPackages.pfff
    ocamlPackages.yaml
    pkg-config
  ];

  nativeBuildInputs = [
    tree-sitter
  ];
}
