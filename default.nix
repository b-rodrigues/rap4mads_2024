let
 pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/194846768975b7ad2c4988bdb82572c00222c0d7.tar.gz") {};
 rpkgs = builtins.attrValues {
  inherit (pkgs.rPackages) quarto Ecdat devtools janitor plm pwt9 rio targets tarchetypes testthat tidyverse usethis formatR;
};
  tex = (pkgs.texlive.combine {
  inherit (pkgs.texlive) scheme-small amsmath framed fvextra environ fontawesome5 orcidlink pdfcol tcolorbox tikzfill;
});
 system_packages = builtins.attrValues {
  inherit (pkgs) R glibcLocalesUtf8 quarto;
};
  in
  pkgs.mkShell {
    LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then  "${pkgs.glibcLocalesUtf8}/lib/locale/locale-archive" else "";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";

    buildInputs = [  rpkgs tex system_packages  ];
      
  }
