#!/bin/bash

# Telegram Bot Configuration
BOT_TOKEN="123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11"
CHAT_ID="123456789" # Replace with your Chat ID
MESSAGE="$1"

# Telegram API URL
URL="https://api.telegram.org/bot${BOT_TOKEN}/sendMessage"

# Send the Message
curl -s -X POST $URL \
    -d chat_id=$CHAT_ID \
    -d text="$MESSAGE" > /dev/null
