# NOTE: no /bin/bash for nix
# this take a youtube url and download it to music directory
# Ensure yt-dlp and notify-send are installed
if ! command -v yt-dlp &>/dev/null || ! command -v notify-send &>/dev/null; then
	echo "yt-dlp and notify-send are required. Please install them first."
	exit 1
fi

# Directory to save the downloaded audio
MUSIC_DIR="$HOME/Documents/Music/"
LOG_FILE="$MUSIC_DIR/yt-dlp-download.log"

# Ensure the music directory exists
mkdir -p "$MUSIC_DIR"

# URL passed as an argument
URL="$1"

# Notify user that download is starting
notify-send "󰎈 YouTube Download" "  Starting download for $URL"
echo "$(date): Starting download for $URL" >>"$LOG_FILE"

# Run yt-dlp to download the audio
yt-dlp -v --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata --output "$MUSIC_DIR/%(title)s.%(ext)s" "$URL" &>>"$LOG_FILE"

# Check if yt-dlp command was successful
if [ $? -eq 0 ]; then
	TITLE=$(yt-dlp --get-title "$URL")
	THUMBNAIL=$(find "$MUSIC_DIR" -type f -name "$(yt-dlp --get-filename -o '%(title)s.%(ext)s' "$URL" | sed 's/\.[^.]*$//')*.jpg")
	if [ -n "$THUMBNAIL" ]; then
		notify-send "󰇚 YouTube Download" "Download complete: $TITLE" -i "$THUMBNAIL"
	else
		notify-send "󰇚 YouTube Download" "Download complete: $TITLE"
	fi
	echo "$(date): Download complete: $TITLE" >>"$LOG_FILE"
else
	notify-send "󰇚 YouTube Download" "Download failed for $URL"
	echo "$(date): Download failed for $URL" >>"$LOG_FILE"
fi
