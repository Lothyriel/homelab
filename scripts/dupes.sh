#!/usr/bin/env bash
set -euo pipefail

find "$1" -type f -printf '%s\t%p\0' |
sort -z -n |
awk -v RS='\0' -F '\t' '
{
    if ($1 == prev_size) {
        if (!(prev_file in seen)) {
            printf "%s%c", prev_file, 0
            seen[prev_file] = 1
        }
        if (!($2 in seen)) {
            printf "%s%c", $2, 0
            seen[$2] = 1
        }
    }
    prev_size = $1
    prev_file = $2
}' |
xargs -0 sha256sum |
sort |
uniq -w64 -d --all-repeated=separate
