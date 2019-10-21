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
  echo "$key";
}

main()
{
  caps=$(get_keylock_status 2);
  num=$(get_keylock_status 4);
  scroll=$(get_keylock_status 6);

  while :
  do
    caps_=$(get_keylock_status 2);
    num_=$(get_keylock_status 4);
    scroll_=$(get_keylock_status 6);

    if [ "$caps" != "$caps_" ]; then
      notify-send "Key hook" "CapsLock is ${caps_}";
      caps=$caps_
    fi

    if [ "$num" != "$num_" ]; then
      notify-send "Key hook" "NumLock is ${num_}";
      num=$num_
    fi

    if [ "$scroll" != "$scroll_" ]; then
      notify-send "Key hook" "ScrollLock is ${scroll_}";
      scroll=$scroll_
    fi
  done
}

main;
exit 0;
