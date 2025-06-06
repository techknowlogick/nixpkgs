{
  lib,
  stdenv,
  fetchurl,
  libhdhomerun,
  pkg-config,
  gtk2,
}:

stdenv.mkDerivation rec {
  pname = "hdhomerun-config-gui";
  version = "20250506";

  src = fetchurl {
    url = "https://download.silicondust.com/hdhomerun/hdhomerun_config_gui_${version}.tgz";
    sha256 = "sha256-bmAdPR5r2mKCncQSSHZ6GYtAk3scHpatnmXGy+a/654=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    gtk2
    libhdhomerun
  ];

  configureFlags = [ "CPPFLAGS=-I${libhdhomerun}/include/hdhomerun" ];
  makeFlags = [ "SUBDIRS=src" ];

  installPhase = ''
    runHook preInstall
    install -vDm 755 src/hdhomerun_config_gui $out/bin/hdhomerun_config_gui
    runHook postInstall
  '';

  meta = with lib; {
    description = "GUI for configuring Silicondust HDHomeRun TV tuners";
    homepage = "https://www.silicondust.com/support/linux";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    maintainers = [ maintainers.louisdk1 ];
    mainProgram = "hdhomerun_config_gui";
  };
}
