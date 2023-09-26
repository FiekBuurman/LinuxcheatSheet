#!/bin/bash

WEBHOOK_URL="https://discord.com/api/webhooks/1154401502903930932/VKwX66RNb6ps8RSWaq-LhvbywimdIgECWBQiUWTvsX4dFwW5SHlo9fX7p5v3y9w1-vm3"

# Run apt update and capture the output
UPDATE_RESULT=$(apt update 2>&1)

# Escape backticks in the update result
ESCAPED_RESULT=$(echo "$UPDATE_RESULT" | sed 's/`/\\`/g')

# Message to send
MESSAGE="Apt Update Result:\n\`\`\`\n$ESCAPED_RESULT\n\`\`\`"

echo $MESSAGE
echo -n $MESSAGE | jq -Rsa

# Send the message to Discord webhook
curl -X POST -H "Content-Type: application/json" -d "{\"content\":\"$MESSAGE\"}" "$WEBHOOK_URL"

exit
