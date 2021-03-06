{ mkDerivation, arm-mras-types, base, stdenv }:
mkDerivation {
  pname = "arm-mras-values";
  version = "0.1";
  src = ./.;
  libraryHaskellDepends = [ arm-mras-types base ];
  license = stdenv.lib.licenses.mit;
}
