{
  writeShellApplication,
  wl-screenrec,
  slurp,
  ripdrag,
  libnotify,
  coreutils,
  procps,
}:

writeShellApplication {
  name = "hyprcorder.sh";
  bashOptions = [ "pipefail" ];
  runtimeInputs = [
    wl-screenrec
    slurp
    ripdrag
    libnotify
    coreutils
    procps
  ];
  text = ''
    notify() {
      notify-send "$@"
      echo "$@"
    }
    dir="$HOME/med/vid/scr"
    [ -d "$dir" ] || mkdir -p "$dir"
    filename="$dir/$(date +%y.%m.%d-%H:%M).mp4"

    if pgrep wl-screenrec &>/dev/null; then
      kill -s SIGINT $(pgrep wl-screenrec) && notify "wl-screenrec stopped"
      pushd "$dir" || exit 2
      ripdrag "$(find . -maxdepth 1 -type f -printf '%T@\t%Tc %6k Ki\t%P\n' | sort -n | cut -f 3- | tail -n1)"
      popd || exit 2
      exit 0
    fi

    if [ $# -eq 0 ]; then
      wl-screenrec --audio -b "1 MB" -f "$filename" &
    else
      dim="$(slurp)"
      if [ -z "$dim" ]; then
        notify "No area selected"
        exit 2
      fi
      wl-screenrec -b "1 MB" -f "$filename" -g "$dim" &
    fi

    if pgrep wl-screenrec &>/dev/null; then
      notify "wl-screenrec started"
    else
      notify "wl-screenrec failed to start"
    fi
  '';
}
