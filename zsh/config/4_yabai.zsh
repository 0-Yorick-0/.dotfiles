#launch yabai at startup
if ps aux | grep -v grep | pgrep "yabai"; then
    echo "Yabai is already running"
else
    echo "Starting Yabai"
    yabai --start-service
fi
