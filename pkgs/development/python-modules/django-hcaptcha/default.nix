{ lib
, buildPythonPackage
, fetchFromGitHub
, django
}:

buildPythonPackage rec {
  pname = "django-hcaptcha";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "AndrejZbin";
    repo = "django-hCaptcha";
    # FIXME: see https://github.com/AndrejZbin/django-hcaptcha/issues/11
    rev = "29910669cffe783b2505f842c5da1842bbacd6aa";
    sha256 = "sha256-g6I/CKxaRWuXLVhuAe1auC3+gHwcyYhoc/px+OfP4o8=";
  };

  propagatedBuildInputs = [
    django
  ];

  # No tests
  doCheck = false;

  pythonImportsCheck = [ "hcaptcha" ];

  meta = with lib; {
    description = "Django hCaptcha provides a simple way to protect your django forms using hCaptcha";
    homepage = "https://github.com/django-hcaptcha";
    license = licenses.bsd3;
    maintainers = with maintainers; [ ambroisie ];
  };
}
