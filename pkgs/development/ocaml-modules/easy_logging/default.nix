{ lib, buildDunePackage, fetchFromGitHub, calendar }:
buildDunePackage rec {
  pname = "easy_logging";
  version = "0.8.2";

  minimumOCamlVersion = "4.07";

  useDune2 = true;

  src = fetchFromGitHub {
    owner = "sapristi";
    repo = "easy_logging";
    rev = "v${version}";
    sha256 = "sha256-Xy6Rfef7r2K8DTok7AYa/9m3ZEV07LlUeMQSRayLBco=";
  };

  propagatedBuildInputs = [
    calendar
  ];

  meta = with lib; {
    description = ''
      Module to log messages. Aimed at being both powerful and easy to use
    '';
    homepage = "https://github.com/sapristi/easy_logging";
    license = licenses.mpl20;
    maintainers = with maintainers; [ ambroisie ];
  };
}
