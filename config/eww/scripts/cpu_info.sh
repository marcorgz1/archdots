#!/bin/bash

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_TEMP=$(sensors | grep -m 1 'Package id 0:' | awk '{print $4}')

echo "{\"usage\": $CPU_USAGE, \"temp\": \"$CPU_TEMP\"}"

