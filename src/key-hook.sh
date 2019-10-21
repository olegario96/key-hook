#!/bin/bash

# $1 == 2 -> Array[2] -> Caps
# $1 == 4 -> Array[4] -> Num
# $1 == 6 -> Array[6] -> Scroll
get_keylock_status()
{
  readonly i=$1;
  readonly xset_=$(xset -q | grep Caps);
  set -- "$xset_";
  IFS=":"; declare -a Keylock=($*);
  readonly key="$(echo -e "${Keylock[$i]}" | printf '%s\n' "${Keylock[$i]//[[:digit:]]/}" | tr -d '[:space:]' )";
  eval $key;
  echo "$key";
}

main()
{
    get_keylock_status 2 caps;
    echo $caps;
}
exit 0;
