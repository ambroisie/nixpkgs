{ buildDunePackage, easy_logging, ppx_deriving, ppx_deriving_yojson }:
buildDunePackage {
  pname = "easy_logging_yojson";

  inherit (easy_logging) src version;

  useDune2 = true;

  buildInputs = [
    ppx_deriving
  ];

  propagatedBuildInputs = [
    easy_logging
    ppx_deriving_yojson
  ];

  meta = easy_logging.meta // {
    description = "Configuration loader for easy_logging with yojson backend";
  };
}
