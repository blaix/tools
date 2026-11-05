{ pkgs, lib, tools }:

# The default package.
# Runs any tool in this flake by name, passing along arguments.
let
  bundle = pkgs.symlinkJoin {
    name = "blaix-tools";
    paths = builtins.attrValues tools;
  };

  width = lib.foldl' lib.max 0 (map builtins.stringLength (builtins.attrNames tools));
  toolList = pkgs.writeText "blix-tool-list" (lib.concatLines (lib.mapAttrsToList (name: tool:
    let padding = lib.strings.replicate (width - builtins.stringLength name) " ";
    in "  ${name}${padding}  ${tool.meta.description}"
  ) tools));
in
pkgs.writeShellApplication {
  name = "blix";
  runtimeInputs = [ pkgs.coreutils ];
  text = ''
    if [ $# -lt 1 ] || [ ! -f "${bundle}/bin/$1" ]; then
      echo "Usage: blix <tool> [args...]" >&2
      echo "Tools:" >&2
      cat ${toolList} >&2
      exit 2
    fi
    tool=$1
    shift
    exec "${bundle}/bin/$tool" "$@"
  '';
}
