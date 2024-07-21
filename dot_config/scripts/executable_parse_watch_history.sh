# Check if jq is installed
if ! command -v jq &>/dev/null; then
	echo "jq is not installed. Please install jq to use this feature."
	exit 1
fi

# Path to the watch history file
watch_history_file="$HOME/.cache/ytfzf/watch_hist"

# Parse the JSON and format for fzf
cat "$watch_history_file" | jq -r '.[] | "\(.url) \(.title)"' |
	fzf --preview 'echo {2}' --preview-window up:3:hidden:wrap \
		--bind 'ctrl-y:execute-silent(echo -n {1} | xclip -selection clipboard)+abort' \
		--header 'Press ENTER to rewatch or CTRL-Y to copy URL' \
		--bind 'enter:execute-silent(echo -n {1} | xargs -I {} yt-dlp -o - {} | mpv -)'
