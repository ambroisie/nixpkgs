{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  ffmpeg-headless,
  makeBinaryWrapper,
  nodejs,
  pnpm_9,
  # FIXME: investigate dangling symlinks and missing JS files
  breakpointHook,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "tunarr";
  version = "0.21.5";

  src = fetchFromGitHub {
    owner = "chrisbenincasa";
    repo = "tunarr";
    tag = "v${finalAttrs.version}";
    hash = "sha256-CuinYopGw4plOzi8VdEwekkJuPFWPJtSastoOn7QJ1A=";
  };

  pnpmDeps = pnpm_9.fetchDeps {
    inherit (finalAttrs)
      pname
      version
      src
      ;
    fetcherVersion = 2;
    hash = "sha256-71oSDPuOv+ytonAFdMnnDqy95Nq8EL+7/Kao2GNFOt0=";
  };

  nativeBuildInputs = [
    breakpointHook # FIXME: remove
    makeBinaryWrapper
    nodejs
    pnpm_9.configHook
  ];

  buildPhase = ''
    runHook preBuild

    pnpm turbo bundle --filter=@tunarr/web

    runHook postBuild
  '';

  # FIXME: shamelessly stolen from bash-language-server
  # preInstall = ''
  #   # remove unnecessary files
  #   rm node_modules/.modules.yaml
  #   pnpm --ignore-scripts --prod prune
  #   find -type f \( -name "*.ts" -o -name "*.map" \) -exec rm -rf {} +
  #   # https://github.com/pnpm/pnpm/issues/3645
  #   find node_modules server/node_modules -xtype l -delete
  #
  #   # remove non-deterministic files
  #   rm node_modules/.modules.yaml
  # '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{bin,lib/tunarr}
    cp -r {node_modules,server,shared,types,web} $out/lib/tunarr/

    # FIXME: index.js is not in the output...
    # Create the executable, based upon what happens in npmHooks.npmInstallHook
    makeWrapper ${lib.getExe nodejs} $out/bin/tunarr \
      --suffix PATH : ${lib.makeBinPath [ ffmpeg-headless ]} \
      --inherit-argv0 \
      --add-flags $out/lib/tunarr/server/out/index.js

    runHook postInstall
  '';

  meta = {
    description = "Create a classic TV experience using your own media";
    homepage = "https://github.com/chrisbenincasa/tunarr";
    changelog = "https://github.com/chrisbenincasa/tunarr/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.zlib;
    maintainers = with lib.maintainers; [ ambroisie ];
    mainProgram = "tunarr";
    platforms = lib.platforms.all;
  };
})
