{ pkgs }:

# Serve the current directory over HTTP on the first free port in 8100-8199.
pkgs.writeShellApplication {
  name = "serve-static";
  runtimeInputs = [ pkgs.python3 ];
  text = ''
    port=8100
    until python -c "import socket; socket.socket().bind((''', $port))" 2>/dev/null; do
      port=$((port + 1))
      if (( port > 8199 )); then
        echo "No free port in 8100-8199" >&2
        exit 1
      fi
    done
    exec python -m http.server "$port" "$@"
  '';
}
