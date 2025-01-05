#!/bin/bash
[[ $- != *i* ]] && return
date
#export GTK_THEME=Plata:dark
set -o emacs
#if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
#	read -rn1 -p '> Sway?' ask
#	case $ask in
#		'a'|'y'|'s')
#			exec wl
#			;;
#	esac
#fi
#[[ $- == *i* ]] && source /bedrock/strata/artix/usr/share/blesh/ble.sh --noattach
cpuboost() {
	doas sh -c 'echo 1 > /sys/devices/system/cpu/cpufreq/boost'
}
function batt
	case "$1" in
		p)
		    printf '%s' "$(</sys/class/power_supply/BAT1/capacity)% ";;
		*)
			echo "$(</sys/class/power_supply/BAT1/capacity)%"
	esac

function clock {
	tty-clock -s -c -C 7
}
	
function states {
	printf '\e[?25l'
	get-c
	((cy==LINES)) && ((cy--))
	stty -echo -icanon time 0 min 0
	printf '\e[;r'
	{ #\e[K
		printf '\e[%d;0H\e[30;47m' $LINES
		printf '%s\e[37;41m▓▒░\e[30m' "$PWD"
		printf '%s\e[31;43m▓▒░\e[30m' "$(date '+%T    %d.%m.%+4Y')"
		printf 'tty - %s\e[33;42m▓▒░\e[30m' "$(tty)"
		printf 'baterie - %s%%\e[32;46m▓▒░\e[30m' "$(</sys/class/power_supply/BAT1/capacity)"
		printf 'zvuk - %s\e[36;44m▓▒░\e[30m' "$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master))"
		printf 'jas - %s%%\e[34;45m▓▒░\e[30m' "$(</sys/class/backlight/amdgpu_bl0/actual_brightness)"
		printf 'wifi - %s \e[m\e[35;47m▓▒░\e[K\e[m' "$(wpa_cli status | grep '^ssid' | cut -f2 -d'=')"
	}
	printf '\e[?25h'
	printf '\e[0;%dr' $((LINES-1))
	printf '\e[%d;%dH' $cy $cx
	stty sane
}
function get-c {
    IFS='[;' read -p $'\e[6n' -d R -rs _ cy cx _
}

function reload {
	exec bash
}

stratall()
	for stratum in $(brl list)
	do
		printf '\e[31m%s\e[m\n' "$stratum"
		strat "$stratum" "$@"
	done

rat() (
	match="$1"
	shift
	cd /bedrock/strata
	strat "$match"* $@
)
function mpvn {
	printf '%q\n' * | sort -n | xargs mpv --no-audio-display
}
function ge {
	alacritty msg config window.padding.y=20
	emacs "$@"
	alacritty msg config window.padding.y=32
}
function e {
	em() {
		emacs "$@"
		alacritty
	}
	em "$@" &
	exit
}
function htp {
	alacritty-swap htop
	htop "$@"
	alacritty msg config -r
}
alias htop='htp'

function das {
	alacritty-swap root
	doas "$@"
	alacritty msg config -r
}
#alias doas='das'


function watt {
	cat /sys/class/power_supply/BAT1/current_now /sys/class/power_supply/BAT1/voltage_now | xargs | awk '{print $1*$2/1e12 " W"}'
}
function eth {
	doas sh -c 'echo on > "/sys/bus/pci/devices/0000:02:00.0/power/control"'
}

function cag {
	XKB_DEFAULT_LAYOUT="cz,cz"\
	XKB_DEFAULT_VARIANT=",rus"\
	XKB_DEFAULT_NUMLOCK=enable\
	XKB_DEFAULT_OPTIONS="compose:lctrl-altgr,grp:win_space_toggle"\
	REPEAT_RATE=40\
	REPEAT_DELAY=250\
	wl cage -s -d alacritty
}

#PS1="\w \[\e[0;33m\]$\[\e[0m\] \[\e]0;\w\a\]"
PS1="\w \[\e[1m\]%\[\e[0m\] \[\e]0;\w\a\]"

#PS1="\[\e[4m\w \[\e[1m\]$\[\e[0m\] \[\e]0;\w\a\]"
shopt -u globstar
[ "$TERM" = linux ] && {
#	PROMPT_COMMAND="states"
#	PROMPT_COMMAND="batt -p"
#	PS1="\[\e[31m\]$\[\e[0m\] \[\e]0;\w\a\]"
	bash bin/setup-tty
	PS1="\w % \[\e]0;\w\a\]"
}
source posix-alias
source posix-var

source mcd
mcd_index=(
	[soul]="~/Hudba/soul/"
	[s]="~/Hudba/soul/"
	[g]="~/garbáž/"
	[m]="~/mng/"
	[u]="~/umen/"
	[ui]="~/umen/img/"
)
mcd-index


function setupble {
	bleopt filename_ls_colors="$LS_COLORS"
	bind 'set completion-ignore-case on'
	bleopt history_share=1
	[[ ${BLE_VERSION-} ]] && ble-attach
}
#setupble
