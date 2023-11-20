#!/usr/bin/env bash
# 112314001

set -e
set -o nounset

EC_SUCCESS=0
EC_INVARGC=1
EC_FILENOEX=2
EC_FILENOREG=3
EC_FILENORW=4
EC_OTHER=5

if [[ "${#@}" -ne 2 ]]; then
	>&2 echo "USAGE: $0 FILE1 FILE2"
	exit "$EC_INVARGC"
fi

f1="$1"
f2="$2"

if [[ ! -e "$f1" ]] || [[ ! -e "$f2" ]]; then
	>&2 echo "At least one of the files does not exist."; exit "$EC_FILENOEX"
elif [[ ! -f "$f1" ]] || [[ ! -f "$f2" ]]; then
	>&2 echo "At least one of the files is not regular."; exit "$EC_FILENOREG"
elif [[ ! -r "$f1" ]] || [[ ! -r "$f2" ]] || [[ ! -w "$f1" ]] || [[ ! -w "$f2" ]]; then
	>&2 echo "At least one of the files is not readable/writeable."; exit "$EC_FILENORW"
fi

tmpf="$(tempfile)"

function onerr {
	>&2 echo "Something went wrong.";
	rm "$tmpf"

	# This seems to have no effect on an interruption
	exit "$EC_OTHER"
}

mv "$f1" "$tmpf" || onerr
mv "$f2" "$f1" || onerr
mv "$tmpf" "$f2" || onerr

# No need to delete $tmpf as it has been moved.

exit "$EC_SUCCESS"
