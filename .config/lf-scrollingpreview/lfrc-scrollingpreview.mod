set previewer lf-scrollingpreview-previewer

map <lt> decoffset
map <gt> incoffset

cmd incoffset &{{
	# offset="$(cat "$LF_SCROLLINGPREVIEW_TEMPDIR/offset")"
	# echo "$(( offset + 1 ))" >"$LF_SCROLLINGPREVIEW_TEMPDIR/offset"
	export LF_SCROLLINGPREVIEW_TEMPVAR="$(( LF_SCROLLINGPREVIEW_TEMPVAR +1 ))"
}}

cmd decoffset &{{
	# offset="$(cat "$LF_SCROLLINGPREVIEW_TEMPDIR/offset")"
	# if [ "$offset" -gt 1 ]; then
	# 	echo "$(( offset - 1 ))" >"$LF_SCROLLINGPREVIEW_TEMPDIR/offset"
	# fi
	if [ "$LF_SCROLLINGPREVIEW_TEMPVAR" -gt 1 ]; then
		export LF_SCROLLINGPREVIEW_TEMPVAR="$(( LF_SCROLLINGPREVIEW_TEMPVAR -1 ))"
	fi
}}

# Put additional configuration which shall only apply to lf-scrollingpreview below
