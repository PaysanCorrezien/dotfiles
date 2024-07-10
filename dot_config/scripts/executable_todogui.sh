set -e
# TODO=$(rofi -dmenu -l 0 -yoffset -300 -p "Todo:")
TODO=$(rofi -dmenu -l 0 -yoffset -300 -p "Todo:" -theme "~/.config/rofi/launchers/type-6/style-1.rasi")

if [[ -n $TODO ]]; then
	# tod t q -c "$TODO"
	# NOTE: hardcoded inbox value or it doesnt work
	# TODO: replace zith 'tod' when nixpackage exist for it
	todoist add -P 2320160004 "$TODO"
	notify-send -a Todoist "Saved Todo: $TODO"
fi
# credit : https://www.reddit.com/r/todoist/comments/1dkjc7v/global_quickadd_task_shortcut_on_linux/
