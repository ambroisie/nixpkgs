{ lib
, buildPythonPackage
, fetchFromGitHub
, bleach
}:

buildPythonPackage rec {
  pname = "bleach-allowlist";
  version = "1.0.3";

  src = fetchFromGitHub {
    owner = "yourcelf";
    repo = "bleach-allowlist";
    # FIXME: see https://github.com/yourcelf/bleach-allowlist/issues/5
    rev = "05484ab6a6da1ccedee25709595f11f0981b3192";
    sha256 = "sha256-/EEw6QaCLThYZCpjtbhPF7D56DbRymkAU2DqJ2J/F8M=";
  };

  propagatedBuildInputs = [
    bleach
  ];

  # No tests
  doCheck = false;

  pythonImportsCheck = [ "bleach_allowlist" ];

  meta = with lib; {
    description = "Curated lists of tags and attributes for sanitizing html";
    homepage = "https://github.com/yourcelf/bleach-allowlist";
    license = licenses.bsd2;
    maintainers = with maintainers; [ ambroisie ];
  };
}
