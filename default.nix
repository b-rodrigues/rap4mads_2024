let
 pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/e1b70fb06158edd5dde073031fb367b6e709cf3f.tar.gz") {};
 rpkgs = builtins.attrValues {
  inherit (pkgs.rPackages) quarto Ecdat devtools janitor plm pwt9 rio targets tarchetypes testthat tidyverse usethis formatR renv visNetwork;
};
  tex = (pkgs.texlive.combine {
  inherit (pkgs.texlive) scheme-small amsmath framed fvextra environ fontawesome5 orcidlink pdfcol tcolorbox tikzfill;
});
 system_packages = builtins.attrValues {
  inherit (pkgs) R glibcLocalesUtf8 quarto;
};

  myPackage = [(pkgs.rPackages.buildRPackage {
  name = "myPackage";
  src = pkgs.fetchgit {
    url = "https://github.com/b-rodrigues/myPackage";
    branchName = "master";
    rev = "e9d9129de3047c1ecce26d09dff429ec078d4dae";
    sha256 = "sha256-u/tIo9L+S12ssGNlQu7AVHG5W5OTpXZ+rHn1Pz6RIKs=";
    };
propagatedBuildInputs = builtins.attrValues {
        inherit (pkgs.rPackages) 
          dplyr
          janitor
          rlang;
      };
  }) 
  ];

  in
  pkgs.mkShell {
    LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then  "${pkgs.glibcLocalesUtf8}/lib/locale/locale-archive" else "";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";

    buildInputs = [ rpkgs tex system_packages myPackage ];
      
  }
