#launch yabai at startup
if ! ps aux | grep -v grep | pgrep "yabai"; then
    echo "Starting Yabai"
    yabai --start-service
fi
