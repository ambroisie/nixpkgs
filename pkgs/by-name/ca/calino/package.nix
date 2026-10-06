{ lib
, fetchFromGitHub
, fetchPnpmDeps
, nodejs-slim
, pnpmBuildHook
, pnpmConfigHook
, pnpm_10
, stdenv
, updateSampleEvents ? false
}:
let
  pnpm = pnpm_10.override { inherit nodejs-slim; };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "calino";
  version = "0.38.0";

  src = fetchFromGitHub {
    owner = "Ivan-Malinovski";
    repo = "calino";
    tag = "v${finalAttrs.version}";
    hash = "sha256-DaT4vJB1/zTPwWnoDvHHQT7XlhmctHVLMIoedgs/1B4=";
  };

  nativeBuildInputs = [
    nodejs-slim
    pnpm
    pnpmBuildHook
    pnpmConfigHook
  ];

  postPatch = lib.optionalString (!updateSampleEvents) ''
    # Updating the sample events relies on build datetime, not reproducible
    substituteInPlace package.json \
      --replace-fail "node scripts/update-sample-events.mjs &&" ""
  '';

  installPhase = ''
    runHook preInstall

    cp -r dist $out

    runHook postInstall
  '';

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    inherit pnpm;
    fetcherVersion = 4;
    hash = "sha256-7V/Ej1xiVu8b4sLiADulSZtZ0kb3nRzTqqYfIGTPxGc=";
  };
})
