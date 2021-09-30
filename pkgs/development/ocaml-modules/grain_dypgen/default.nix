{stdenv, lib, fetchFromGitHub, ocaml, findlib}:
let
  pname = "grain_dypgen";
in
if ! lib.versionAtLeast ocaml.version "4.07"
then throw "${pname} is not available for OCaml ${ocaml.version}"
else
stdenv.mkDerivation rec {
  inherit pname;
  version = "0.2";

  src = fetchFromGitHub {
    owner = "grain-lang";
    repo = "dypgen";
    rev = version;
    sha256 = "sha256-fKuO/e5YbA2B7XcghWl9pXxwvKw9YlhnmZDZcuKe3cs=";
  };

  buildInputs = [ocaml findlib];

  createFindlibDestdir = true;

  buildPhase = ''
    make
  '';

  makeFlags = [ 
    "BINDIR=$(out)/bin"
    "MANDIR=$(out)/usr/share/man/man1"
    "DYPGENLIBDIR=$(out)/lib/ocaml/${ocaml.version}/site-lib"
  ];

  meta = {
    homepage = "https://github.com/grain-lang/dypgen";
    description = ''
      A fork of the dypgen GLR self extensible parser generator, to support
      OCaml 4.07>=.
    '';
    license = lib.licenses.cecill-b;
    platforms = ocaml.meta.platforms or [];
  };
}
