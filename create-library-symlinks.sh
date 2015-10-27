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

  for entry in $LIBRARIES_DIR/$name*; do
    echo "- removing symlink: $entry"
    rm $entry
  done

  echo "- creating symlinks"
  ln -s $(PWD)/lib/$name* $LIBRARIES_DIR/

  echo "- - -"
  echo "($name done)"
  echo
}
