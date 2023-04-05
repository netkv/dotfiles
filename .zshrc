#!/bin/zsh
export QT_QPA_PLATFORM=wayland
export MOZ_ENABLE_WAYLAND=1
export EDITOR="emacs"
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_STYLE_OVERRIDE=qt5ct-style

alias ls='ls --color=auto'
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
	read -r ask
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

e() {
	em "$@" &
	disown
	exit
}
em() {
	emacs "$@"
	alacritty
}


alias ge='emacs --no-window-system'
alias he='nvim'
alias bxe='bashbox bano'
alias xr='xbps-query -R'
alias btom='btm --basic'
alias tv='mpv --vo=tct'
alias d='date +%s'
alias fp='realpath'
alias xrr='xr -R'

[ $TERM = linux ] && {
	PS1='\033[48;5;200m \e[0m '
	if [ "$TERM" = "linux" ]; then

		setfont cozette
		#echo -en "\e]P01d2021" #černá
		echo -en "\e]P0000000" #černá
		echo -en "\e]P8888888" #tmavě bílá
		echo -en "\e]P1bb2040" #červená
		echo -en "\e]P9ff4066" #světle červená
		echo -en "\e]P2338060" #zelená
		echo -en "\e]PA55aa80" #světle zelená
		echo -en "\e]P3cc8844" #žlutá
		echo -en "\e]PBffcc88" #světle žlutá
		echo -en "\e]P6655aa" #modrá
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

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob notify
unsetopt beep nomatch
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ntk/.zshrc'
autoload -Uz compinit
compinit
export MICRO_TRUECOLOR=1
autoload -U colors && colors
PS1="%F{1}$ %{$reset_color%}"
#PS1="%{%{$fg[red]%}$  %{$reset_color%}"
RPROMPT="%{$fg[red]%}%~%{$reset_color%}"
#RPROMPT="%{$fg[white]%}${curstrat}%{$reset_color%}"
#preexec() { print -Pn "\e]0;$1\a" }
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

wm() {
	if test -z "${XDG_RUNTIME_DIR}"; then
				export XDG_RUNTIME_DIR="/tmp/$(id -u)-sway"
				if ! test -d "${XDG_RUNTIME_DIR}"; then
					mkdir "${XDG_RUNTIME_DIR}"
					chmod 0700 "${XDG_RUNTIME_DIR}"
				fi
			fi
	exec "$1"
}
alias dotsgit="git --git-dir=$HOME/src/dots --work-tree=$HOME"
alias dots="${HOME}/src/dots/dots"
