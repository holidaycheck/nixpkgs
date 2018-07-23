{stdenv, autoconf, automake, fetchFromGitHub, pkgconfig, xorg, glib, gobjectIntrospection, xcbproto, json-glib, gtk-doc, which, libtool}:

stdenv.mkDerivation rec {

  version = "0.6.0";
  name ="i3ipc-glib-${version}";

  src = fetchFromGitHub {
    owner = "acrisci";
    repo = "i3ipc-glib";
    rev = "v${version}";
    sha256 = "1gmk1zjafrn6jh4j7r0wkwrpwvf9drl1lcw8vya23i1f4zbk0wh4";
  };

  preConfigure = "./autogen.sh";

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [
    autoconf
    automake
    glib
    json-glib
    gobjectIntrospection
    xorg.libxcb
    xcbproto
    gtk-doc
    which
    libtool
  ];

}
