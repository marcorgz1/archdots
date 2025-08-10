#!/bin/bash

set -euo pipefail

extract_first_integer_celsius_from_sensors() {
  # Parse common fields from `sensors` output:
  # - AMD k10temp: "Tdie:" or "Tctl:"
  # - Some Intel/older: "Package id 0:" or "Core 0:"
  sensors 2>/dev/null | awk '
    /Tdie:|Tctl:|Package id 0:|Core 0:/ {
      for (i=1; i<=NF; i++) {
        if ($i ~ /\+[0-9]+(\.[0-9]+)?°C/) {
          gsub(/\+|°C/, "", $i);
          split($i, a, ".");
          print a[1];
          exit;
        }
      }
    }
  '
}

read_hwmon_sysfs() {
  # Prefer labels named Tdie or Tctl, then Package id 0, else first temp*_input
  for lbl in /sys/class/hwmon/hwmon*/temp*_label; do
    [ -r "$lbl" ] || continue
    name=$(tr -d '\n' < "$lbl" || true)
    case "$name" in
      Tdie|Tctl|"Package id 0")
        base=${lbl%_label}
        if [ -r "${base}_input" ]; then
          val=$(cat "${base}_input" 2>/dev/null || echo "")
          if [[ "$val" =~ ^[0-9]+$ ]]; then
            echo $(( val / 1000 ))
            return 0
          fi
        fi
        ;;
    esac
  done

  # Fallback: first temp*_input found
  for input in /sys/class/hwmon/hwmon*/temp*_input; do
    [ -r "$input" ] || continue
    val=$(cat "$input" 2>/dev/null || echo "")
    if [[ "$val" =~ ^[0-9]+$ ]]; then
      echo $(( val / 1000 ))
      return 0
    fi
  done

  return 1
}

main() {
  # Try lm-sensors if available
  if command -v sensors >/dev/null 2>&1; then
    if out=$(extract_first_integer_celsius_from_sensors); then
      if [[ "$out" =~ ^[0-9]+$ ]]; then
        echo "$out"
        exit 0
      fi
    fi
  fi

  # Fallback to sysfs
  if out=$(read_hwmon_sysfs); then
    echo "$out"
    exit 0
  fi

  # If all methods fail, print nothing and non-zero exit
  exit 1
}

main "$@"

