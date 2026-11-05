{ pkgs }:

# Worktrees go in ../<repo>.worktrees/<branch>, so every project's worktrees
# live in the same predictable place. Aligns with the `worktree-rm` package for
# removing them.
pkgs.writeShellApplication {
  name = "worktree";
  meta.description = "Make a branch and check it out in a worktree beside the main checkout";
  runtimeInputs = with pkgs; [ git gnused ];
  text = ''
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
      echo "Usage: worktree <branch> [base]   (base defaults to main)" >&2
      exit 2
    fi
    name=$1
    base=''${2:-main}

    main=$(git worktree list --porcelain | sed -n '1s/^worktree //p')
    dir="$main.worktrees/$name"
    git worktree add -b "$name" "$dir" "$base"
    echo
    echo "Worktree: $dir"
    echo "Branch:   $name"
  '';
}
