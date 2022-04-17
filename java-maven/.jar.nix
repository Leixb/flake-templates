{ lib
, stdenv
, maven
, jre8
, makeWrapper
, callPackage
}:

let
  repository = callPackage ./.build-maven-repo.nix { };
in

stdenv.mkDerivation rec {
  pname = "hello";
  version = "0.0.1-SNAPSHOT";

  src = ./.;

  nativeBuildInputs = [ maven makeWrapper ];

  buildPhase = ''
    runHook preBuild

    echo "Using repository ${repository}"
    mvn --offline -Dmaven.repo.local=${repository} package;

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    classpath=$(find ${repository} -name "*.jar" -printf ':%h/%f');
    install -Dm644 target/${pname}-${version}.jar $out/share/java/${pname}-${version}.jar

    makeWrapper ${jre8}/bin/java $out/bin/${pname} \
      --add-flags "-classpath $out/share/java/${pname}-${version}.jar:''${classpath#:}" \
      --add-flags "Main"

    runHook postInstall
  '';
}
