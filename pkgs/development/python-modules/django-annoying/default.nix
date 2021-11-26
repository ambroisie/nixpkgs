{ lib
, buildPythonPackage
, fetchFromGitHub
, django
, six
}:

buildPythonPackage rec {
  pname = "django-annoying";
  version = "0.10.6";

  src = fetchFromGitHub {
    owner = "skorokithakis";
    repo = "django-annoying";
    rev = "v${version}";
    sha256 = "sha256-M1zOLr1Vjf2U0xlW66Mpno+S+b4IKLklN+kYxRaj6cA=";
  };

  propagatedBuildInputs = [
    django
    six
  ];

  # Install check fails due to unconfigured django
  doCheck = false;

  meta = with lib; {
    description = "A django application that tries to eliminate annoying things in the Django framework";
    homepage = "https://skorokithakis.github.io/django-annoying/";
    license = licenses.bsd3;
    maintainers = with maintainers; [ ambroisie ];
  };
}
