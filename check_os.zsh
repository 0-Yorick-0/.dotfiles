#! /usr/bin/env zsh

uname_out="$(uname -s)"

case "${uname_out}" in
	Linux*)		machine=Linux;;
	Darwin*)	machine=Mac;;
	*)		machine="UNKNOWN:${uname_out}"
esac
echo ${machine}
