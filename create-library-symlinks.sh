set -e

if [ -z ${LIBRARIES_DIR+x} ]; then
  echo "LIBRARIES_DIR must be set to the libraries directory path... exiting"
  exit 1
fi

if [ ! -d "$LIBRARIES_DIR" ]; then
  echo "$LIBRARIES_DIR does not exit... exiting"
  exit 1
fi

function symlink-library {
  name=$1

  echo
  echo "Symlinking $name"
  echo "- - -"

  for entry in $(PWD)/lib/$name*; do
    filename=$(basename $entry)
    dest="$LIBRARIES_DIR/$filename"

    if [ -h "$dest" ]; then
      echo "- removing symlink: $entry"
      rm $dest
    fi

    echo "- symlinking $filename to $LIBRARIES_DIR"

    cmd="ln -s $entry $dest"
    echo $cmd
    ($cmd)

    echo
  done

  echo "- - -"
  echo "($name done)"
  echo
}
