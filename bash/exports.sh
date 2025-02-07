# exports

SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

CONFIG_DIR="$(realpath "$DIR/..")"
export  CONFIG_DIR
export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin:/opt/nvim-linux64/bin"
export EDITOR=nvim
export VISUAL=nvim
