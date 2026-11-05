# Blaix Tools and Stuff

Little tools I write for myself.

Currently only distributed via nix flakes.
If you have nix with flakes enabled,
look for tools in `pkgs/`,
and run them with `nix run github:blaix/tools#<package name>`.
For example:

`nix run github:blaix/tools#worktree -- my-worktree`

IF you want access to them all easily, install the `github:blaix/tools` flake
which puts `blix` on your PATH so you can run any of the tools by name, passing
any arguments through.
For example:

```
blix worktree my-worktree
```
