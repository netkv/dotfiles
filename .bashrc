#!/bin/bash
set -o emacs
[[ $- != *i* ]] && return
export QT_QPA_PLATFORM=wayland
export MOZ_ENABLE_WAYLAND=1
export EDITOR="emacs"
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_STYLE_OVERRIDE=qt5ct-style
alias ls='ls --color=auto'
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
	read -rn1 -p '> Sway?' ask
	case $ask in
		'a'|'y'|'s')
			if test -z "${XDG_RUNTIME_DIR}"; then
				export XDG_RUNTIME_DIR="/tmp/$(id -u)-sway"
				if ! test -d "${XDG_RUNTIME_DIR}"; then
					mkdir "${XDG_RUNTIME_DIR}"
					chmod 0700 "${XDG_RUNTIME_DIR}"
				fi
			fi
			exec sway
			;;
	esac
fi
ex() {
	execlineb $@
}
e() {
	execlineb -c "$@"
}
cpuboost() {
	doas sh -c 'echo 1 > /sys/devices/system/cpu/cpufreq/boost'
}
nosus() {
	doas sv down acpid
}
yessus() {
	doas sv up acpid
}
brlall() {
	for stratum in $(brl list); {
		print "${stratum}:"
		strat "${stratum}" "$@"
	}
}
alias ge='emacs --no-window-system'
alias he='nvim'
alias bxe='bashbox bano'
alias xr='xbps-query -R'
alias btom='btm --basic'
alias tv='mpv --vo=tct'
alias d='date +%s'
alias fp='realpath'
#PS1="\033[38;2;0;255;17m\w \$ \033[0;0m"
#PS1="\033[38;2;0;255;147m\$ \033[0;0m"
#PS1="\033[35m> \033[0;0m"
#PS1="\e[0;30m▶ "
PS1="\e[0;31m$\e[0m \e]0;\w\a"
source /bedrock/strata/arch/usr/share/blesh/ble.sh
shopt -u globstar
rz() {
	zig build-exe "$1"
	IFS='.'
	filename="${1%/}"
	filename="${filename##*/}"
	filenamesplit=($filename)
	./"${filenamesplit[0]}"
}
[ $TERM = linux ] && {
	#setfont iso02.14
	setfont cozette
	#PS1='\033[48;5;200m \e[0m '
	if [ "$TERM" = "linux" ]; then
		#echo -en "\e]P01d2021" #černá
		echo -en "\e]P0000000" #černá
		echo -en "\e]P8808080" #tmavě bílá
		echo -en "\e]P1bb2040" #červená
		echo -en "\e]P9ff4066" #světle červená
		echo -en "\e]P2338066" #zelená
		echo -en "\e]PA55aa80" #světle zelená
		echo -en "\e]P3cc8844" #žlutá
		echo -en "\e]PBffcc88" #světle žlutá
		echo -en "\e]P46655aa" #modrá
		echo -en "\e]PC8070dd" #světle modrá
		echo -en "\e]P5bb55bb" #fialová
		echo -en "\e]PDdd77dd" #světle fialová
		echo -en "\e]P6447099" #tyrkysová
		echo -en "\e]PE66aaaa" #světle tyrkysová
		echo -en "\e]P7444444" #světle černá
		echo -en "\e]PFffffff" #bílá
		#clear #for background artifacting
	fi
}
wm() {
	if test -z "${XDG_RUNTIME_DIR}"; then
				export XDG_RUNTIME_DIR="/tmp/$(id -u)-wm"
				if ! test -d "${XDG_RUNTIME_DIR}"; then
					mkdir "${XDG_RUNTIME_DIR}"
					chmod 0700 "${XDG_RUNTIME_DIR}"
				fi
			fi
	exec dbus-launch "$1"
}
#abcdefghchijklmnopqrstuvwxyz
alias xrr='xr -R'
