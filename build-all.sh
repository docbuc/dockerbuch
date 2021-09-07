#!/bin/bash
#
# build docker images (and push)
# needs a first line in the dockerfile like
#
# # Datei: x/y/Dockerfile (docbuc/abc:latest)

set -e
set -o pipefail

dry_run=0
push=0

while getopts 'np' opt; do
    case "$opt" in
        n) dry_run=1 ;;
        p) push=1 ;;
        *) echo 'error in command line parsing' >&2
           exit 1
    esac
done

SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
REPO_URL="docbuc/"
IMGPATTERN="[[:alnum:]]*\/[[:alnum:]:-]*"


compile() {
	f=$1
	dfile=${f##*/}
	build_dir=${f%/*}
	if $(head -1 $f | grep -q -E "\($IMGPATTERN\)")
	then
		img=$(head -1 $f | sed -E "s/^# .*\(($IMGPATTERN)\)/\1/")
		echo -e "\e[31m-----------------> Start build $img\e[0m ($dfile)"
		cmd="docker build --rm --force-rm -f $f -t \"$img\" \"${build_dir}\" || return 1"
		if [ "$dry_run" -eq 0 ]; then
			eval $cmd
		else
			echo $cmd
		fi
		if [ "$push" -eq 1 ]; then
			docker push $img
		fi
	# else
		# echo "No build info for $f"
	fi
}

IFS=$'\n'
DFILES=$(find . -type f -iname 'Dockerfile*' | sed 's|./||' | sort)
unset IFS

for i in $DFILES
do
	compile $i
done
