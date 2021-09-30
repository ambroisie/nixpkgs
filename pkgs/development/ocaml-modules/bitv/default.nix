{ lib, buildDunePackage, fetchFromGitHub }:

buildDunePackage rec {
  pname = "bitv";
  version = "1.6";

  useDune2 = true;

  src = fetchFromGitHub {
    owner = "backtracking";
    repo = "bitv";
    rev = version;
    sha256 = "sha256-n0XOHtg8E97uw9RjZxqmAitU7l43n1/ujlXOh6SlRS4=";
  };

  meta = {
    description = "A bit vector library for OCaml";
    license = lib.licenses.lgpl21;
    homepage = "https://github.com/backtracking/bitv";
    maintainers = [ lib.maintainers.vbgl ];
  };
}
