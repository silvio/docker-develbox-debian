#!/usr/bin/env bash

name=$(basename ${0})

# save error from the previouse process
# and use this to get status notification
previouse_error=$?

case "${name}" in
	"sbcn"*)
		sbc notify "notification from ${HOSTNAME}"
		exit
		;;

	"sbcc"*)
		result="OK"
		[[ ${previouse_error} -gt 0 ]] && result="KO"
		sbc notify "${result}: notification from ${HOSTNAME}"
		exit
		;;

	*)
		sbc nix
		# mode not supported
		;;
esac
