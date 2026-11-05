{ pkgs }:

pkgs.writeShellApplication {
  name = "worktree-rm";
  meta.description = "Remove a worktree made by `worktree`, keeping its branch";
  runtimeInputs = with pkgs; [ git gnused coreutils ];
  text = ''
    if [ $# -ne 1 ]; then
      echo "Usage: worktree-rm <branch>" >&2
      exit 2
    fi
    name=$1

    main=$(git worktree list --porcelain | sed -n '1s/^worktree //p')
    git worktree remove "$main.worktrees/$name"
    # Branch names with slashes leave empty parent directories.
    d=$(dirname "$main.worktrees/$name")
    while [ "$d" != "$main.worktrees" ] && rmdir "$d" 2>/dev/null; do d=$(dirname "$d"); done
    echo "Removed $main.worktrees/$name; branch $name kept"
  '';
}
