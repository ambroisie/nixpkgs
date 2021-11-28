{ lib
, buildPythonPackage
, fetchPypi
, fetchpatch
, isPy27
, rdflib
, html5lib
}:

buildPythonPackage rec {
  pname = "pyRdfa3";
  version = "3.5.3";
  disabled = isPy27;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-FXZjqSuH3zRbb2m94jXf9feXiRYI4S/h5PqNrWhxMa4=";
  };

  patches = [
    # Syntax error in the setup.py file
    (fetchpatch {
      url = "https://github.com/chartbeat-labs/pyrdfa3/commit/498205ee6c9bd48f406e3460e4ebd83183fcfbad.patch";
      sha256 = "sha256-AOp+o5eBWYgrdb+XdOwAGEiI5AmYSqs8x9Wf1qS9/wQ=";
    })
  ];

  propagatedBuildInputs = [
    rdflib
    html5lib
  ];

  # Does not work with python3
  doCheck = false;

  pythonImportsCheck = [ "pyRdfa" ];

  meta = with lib; {
    description = "RDFa 1.1 distiller/parser library";
    homepage = "https://www.w3.org/2012/pyRdfa/";
    license = licenses.w3c;
    maintainers = with maintainers; [ ambroisie ];
  };
}
