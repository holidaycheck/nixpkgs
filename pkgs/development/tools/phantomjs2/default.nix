{ stdenv, fetchurl, unzip }:

stdenv.mkDerivation rec {
  name = "phantomjs-${version}";
  version = "2.1.1";

  buildInputs = [ unzip ];
  phases = "unpackPhase installPhase";

  src = fetchurl ({
      url = "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${version}-macosx.zip";
      sha256 = "1hgqa28pfhgm6k1iw2z91ycpd6gfpki2kimgkqq7xcls464g932k";
    });

  installPhase = ''
    ls
    mkdir -p $out/bin
    cp bin/phantomjs $out/bin
    chmod +x $out/bin/phantomjs
    ls -l $out/bin/phantomjs
  '';

  dontStrip = true;

  meta = with stdenv.lib; {
    description = "Headless WebKit with JavaScript API";
    longDescription = ''
      PhantomJS2 is a headless WebKit with JavaScript API.
      It has fast and native support for various web standards:
      DOM handling, CSS selector, JSON, Canvas, and SVG.

      PhantomJS is an optimal solution for:
      - Headless Website Testing
      - Screen Capture
      - Page Automation
      - Network Monitoring
    '';

    homepage = http://phantomjs.org/;
    license = licenses.bsd3;
    platforms = platforms.darwin;
  };
}
