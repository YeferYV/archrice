#!/usr/bin/env sh

cleanup() {
	#rm -rf "$LF_SCROLLINGPREVIEW_TEMPDIR"
	unset "$LF_SCROLLINGPREVIEW_TEMPVAR"
}

trap cleanup INT HUP EXIT

# LF_SCROLLINGPREVIEW_TEMPDIR="$(mktemp -d -t lf-scrollingpreview-XXXXXX)"
# export LF_SCROLLINGPREVIEW_TEMPDIR
# echo "1" >"$LF_SCROLLINGPREVIEW_TEMPDIR/offset"
export LF_SCROLLINGPREVIEW_TEMPVAR="1"
lf -command "source '${XDG_CONFIG_HOME:-$HOME/.config}/lf-scrollingpreview/lfrc-scrollingpreview'" "$@"
cleanup
