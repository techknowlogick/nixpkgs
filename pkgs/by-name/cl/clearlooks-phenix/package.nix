{
  lib,
  stdenv,
  fetchzip,
}:

stdenv.mkDerivation rec {
  version = "7.1";
  pname = "clearlooks-phenix";

  src = fetchzip {
    url = "https://github.com/jpfleury/clearlooks-phenix/archive/${version}.tar.gz";
    sha256 = "sha256-UJgKPoNcpBkIxITAIn3INsANJn/hD8l9NCr/entbZx8=";
  };

  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/themes/Clearlooks-Phenix
    cp -r . $out/share/themes/Clearlooks-Phenix/
  '';

  preferLocalBuild = true;

  meta = with lib; {
    description = "GTK3 port of the Clearlooks theme";
    longDescription = ''
      The Clearlooks-Phénix project aims at creating a GTK3 port of Clearlooks,
      the default theme for Gnome 2. Style is also included for GTK2, Unity and
      for Metacity, Openbox and Xfwm4 window managers.
    '';
    homepage = "https://github.com/jpfleury/clearlooks-phenix";
    downloadPage = "https://github.com/jpfleury/clearlooks-phenix/releases";
    license = licenses.gpl3;
    maintainers = [ maintainers.prikhi ];
    platforms = platforms.linux;
  };
}
