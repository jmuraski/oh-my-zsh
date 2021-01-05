function zsh_stats() {
  fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}

function uninstall_oh_my_zsh() {
  env ZSH=$ZSH sh $ZSH/tools/uninstall.sh
}

function upgrade_oh_my_zsh() {
  env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
}

function take() {
  mkdir -p $1
  cd $1
}

function trash() {
  local trash_dir="${HOME}/.Trash"
  local temp_ifs=$IFS
  IFS=$'\n'
  for item in "$@"; do
    if [[ -e "$item" ]]; then
      item_name="$(basename $item)"
      if [[ -e "${trash_dir}/${item_name}" ]]; then
        mv -f "$item" "${trash_dir}/${item_name} $(date "+%H-%M-%S")"
      else
        mv -f "$item" "${trash_dir}/"
      fi
    fi
  done
  IFS=$temp_ifs
}
function open_command() {
  emulate -L zsh
  setopt shwordsplit

  local open_cmd

  # define the open command
  case "$OSTYPE" in
    darwin*)  open_cmd='open' ;;
    cygwin*)  open_cmd='cygstart' ;;
    linux*)   open_cmd='xdg-open' ;;
    msys*)    open_cmd='start ""' ;;
    *)        echo "Platform $OSTYPE not supported"
              return 1
              ;;
  esac

  # don't use nohup on OSX
  if [[ "$OSTYPE" == darwin* ]]; then
    $open_cmd "$@" &>/dev/null
  else
    nohup $open_cmd "$@" &>/dev/null
  fi
}

#
# Get the value of an alias.
#
# Arguments:
#    1. alias - The alias to get its value from
# STDOUT:
#    The value of alias $1 (if it has one).
# Return value:
#    0 if the alias was found,
#    1 if it does not exist
#
function alias_value() {
    alias "$1" | sed "s/^$1='\(.*\)'$/\1/"
    test $(alias "$1")
}

#
# Try to get the value of an alias,
# otherwise return the input.
#
# Arguments:
#    1. alias - The alias to get its value from
# STDOUT:
#    The value of alias $1, or $1 if there is no alias $1.
# Return value:
#    Always 0
#
function try_alias_value() {
    alias_value "$1" || echo "$1"
}

#
# Set variable "$1" to default value "$2" if "$1" is not yet defined.
#
# Arguments:
#    1. name - The variable to set
#    2. val  - The default value
# Return value:
#    0 if the variable exists, 3 if it was set
#
function default() {
    test `typeset +m "$1"` && return 0
    typeset -g "$1"="$2"   && return 3
}

#
# Set environment variable "$1" to default value "$2" if "$1" is not yet defined.
#
# Arguments:
#    1. name - The env variable to set
#    2. val  - The default value
# Return value:
#    0 if the env variable exists, 3 if it was set
#
function env_default() {
    env | grep -q "^$1=" && return 0
    export "$1=$2"       && return 3
}


# Required for $langinfo
# zmodload zsh/langinfo

function switchJava() {
export JAVA_HOME=$(/usr/libexec/java_home -v $1)
}

# URL-encode a string
#
# Encodes a string using RFC 2396 URL-encoding (%-escaped).
# See: https://www.ietf.org/rfc/rfc2396.txt
#
# By default, reserved characters and unreserved "mark" characters are
# not escaped by this function. This allows the common usage of passing
# an entire URL in, and encoding just special characters in it, with
# the expectation that reserved and mark characters are used appropriately.
# The -r and -m options turn on escaping of the reserved and mark characters,
# respectively, which allows arbitrary strings to be fully escaped for
# embedding inside URLs, where reserved characters might be misinterpreted.
#
# Prints the encoded string on stdout.
# Returns nonzero if encoding failed.
#
# Usage:
#  omz_urlencode [-r] [-m] [-P] <string>
#
#    -r causes reserved characters (;/?:@&=+$,) to be escaped
#
#    -m causes "mark" characters (_.!~*''()-) to be escaped
#
#    -P causes spaces to be encoded as '%20' instead of '+'
function omz_urlencode() {
  emulate -L zsh
  zparseopts -D -E -a opts r m P

  local in_str=$1
  local url_str=""
  local spaces_as_plus
  if [[ -z $opts[(r)-P] ]]; then spaces_as_plus=1; fi
  local str="$in_str"

  # URLs must use UTF-8 encoding; convert str to UTF-8 if required
  local encoding=$langinfo[CODESET]
  local safe_encodings
  safe_encodings=(UTF-8 utf8 US-ASCII)
  if [[ -z ${safe_encodings[(r)$encoding]} ]]; then
    str=$(echo -E "$str" | iconv -f $encoding -t UTF-8)
    if [[ $? != 0 ]]; then
      echo "Error converting string from $encoding to UTF-8" >&2
      return 1
    fi
  fi

  # Use LC_CTYPE=C to process text byte-by-byte
  local i byte ord LC_ALL=C
  export LC_ALL
  local reserved=';/?:@&=+$,'
  local mark='_.!~*''()-'
  local dont_escape="[A-Za-z0-9"
  if [[ -z $opts[(r)-r] ]]; then
    dont_escape+=$reserved
  fi
  # $mark must be last because of the "-"
  if [[ -z $opts[(r)-m] ]]; then
    dont_escape+=$mark
  fi
  dont_escape+="]"

  # Implemented to use a single printf call and avoid subshells in the loop,
  # for performance (primarily on Windows).
  local url_str=""
  for (( i = 1; i <= ${#str}; ++i )); do
    byte="$str[i]"
    if [[ "$byte" =~ "$dont_escape" ]]; then
      url_str+="$byte"
    else
      if [[ "$byte" == " " && -n $spaces_as_plus ]]; then
        url_str+="+"
      else
        ord=$(( [##16] #byte ))
        url_str+="%$ord"
      fi
    fi
  done
  echo -E "$url_str"
}

# URL-decode a string
#
# Decodes a RFC 2396 URL-encoded (%-escaped) string.
# This decodes the '+' and '%' escapes in the input string, and leaves
# other characters unchanged. Does not enforce that the input is a
# valid URL-encoded string. This is a convenience to allow callers to
# pass in a full URL or similar strings and decode them for human
# presentation.
#
# Outputs the encoded string on stdout.
# Returns nonzero if encoding failed.
#
# Usage:
#   omz_urldecode <urlstring>  - prints decoded string followed by a newline
function omz_urldecode {
  emulate -L zsh
  local encoded_url=$1

  # Work bytewise, since URLs escape UTF-8 octets
  local caller_encoding=$langinfo[CODESET]
  local LC_ALL=C
  export LC_ALL

  # Change + back to ' '
  local tmp=${encoded_url:gs/+/ /}
  # Protect other escapes to pass through the printf unchanged
  tmp=${tmp:gs/\\/\\\\/}
  # Handle %-escapes by turning them into `\xXX` printf escapes
  tmp=${tmp:gs/%/\\x/}
  local decoded
  eval "decoded=\$'$tmp'"

  # Now we have a UTF-8 encoded string in the variable. We need to re-encode
  # it if caller is in a non-UTF-8 locale.
  local safe_encodings
  safe_encodings=(UTF-8 utf8 US-ASCII)
  if [[ -z ${safe_encodings[(r)$caller_encoding]} ]]; then
    decoded=$(echo -E "$decoded" | iconv -f UTF-8 -t $caller_encoding)
    if [[ $? != 0 ]]; then
      echo "Error converting string from UTF-8 to $caller_encoding" >&2
      return 1
    fi
  fi

  echo -E "$decoded"
}
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

redis-prod-cart-east() {
  docker run --rm --name redis-cli-pce -it goodsmileduck/redis-cli redis-cli -h production-basket.s2swdm.ng.0001.use1.cache.amazonaws.com -p 6379
}

redis-stage-cart-east() {
  docker run --rm --name redis-cli-sce -it goodsmileduck/redis-cli redis-cli -h cart-service-carts.vogn0g.ng.0001.use1.cache.amazonaws.com -p 6379
}

redis-prod-cart-west() {
  docker run --rm --name redis-cli-pcw -it goodsmileduck/redis-cli redis-cli -h production-basket.qxj8nc.ng.0001.usw2.cache.amazonaws.com -p 6379
}

redis-stage-cart-west() {
  docker run --rm --name redis-cli-scw -it goodsmileduck/redis-cli redis-cli -h cart-service-carts.14tdzx.ng.0001.usw2.cache.amazonaws.com -p 6379
}

redis-prod-aviator-east() {
  docker run --rm --name redis-cli-pae -it goodsmileduck/redis-cli redis-cli -h prod-aviator-orders2.s2swdm.ng.0001.use1.cache.amazonaws.com -p 6379
}

redis-stage-aviator-east() {
  docker run --rm --name redis-cli-sae -it goodsmileduck/redis-cli redis-cli -h shipt-aviator-ro.vogn0g.ng.0001.use1.cache.amazonaws.com -p 6379
}

redis-prod-aviator-west() {
  docker run --rm --name redis-cli-paw -it goodsmileduck/redis-cli redis-cli -h prod-aviator-orders2.qxj8nc.ng.0001.usw2.cache.amazonaws.com -p 6379
}

redis-stage-aviator-west() {
  docker run --rm --name redis-cli-saw -it goodsmileduck/redis-cli redis-cli -h shipt-aviator-ro.14tdzx.ng.0001.usw2.cache.amazonaws.com -p 6379
}

redis-prod-orders-east() {
  docker run --rm --name redis-cli-poe -it goodsmileduck/redis-cli redis-cli -h prd-cartsvc-orders.s2swdm.ng.0001.use1.cache.amazonaws.com -p 6379
}

redis-prod-orders-west() {
  docker run --rm --name redis-cli-pow -it goodsmileduck/redis-cli redis-cli -h prd-cartsvc-orders.qxj8nc.ng.0001.usw2.cache.amazonaws.com -p 6379
}

redis-stage-orders-east() {
  docker run --rm --name redis-cli-soe -it goodsmileduck/redis-cli redis-cli -h cart-service-orders.14tdzx.ng.0001.usw2.cache.amazonaws.com -p 6379
}

redis-stage-orders-west() {
  docker run --rm --name redis-cli-sow -it goodsmileduck/redis-cli redis-cli -h cart-service-orders.vogn0g.ng.0001.use1.cache.amazonaws.com -p 6379
}

adminOrder() {
  open -a "Google Chrome" "https://admin.shipt.com/admin/orders/$1"
}

adminDrivenOrder() {
  VALUE=$(echo "$1" | tr -d "E_" | tr -d '"')
  open -a "Google Chrome" "https://admin.shipt.com/admin/deliveries/$VALUE"
}

ffile(){
  PVIEW='sed -n $(( {n} - 1 )),$(( {n} + 6 ))p '
  PVIEW+="$1"
  echo $PVIEW
  cat $1 | fzf --preview $PVIEW
}