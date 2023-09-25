#!/bin/bash
TASK="$1"

# run task and store output
TASK_OUTPUT=$(eval "$TASK")
MESSAGE=""

IFS=$'\n'
for line in $TASK_OUTPUT; do
  MESSAGE+="\n$line"
done

if [ -z "$TASK_OUTPUT" ]; then
  COLOR="0xC62020"
  MESSAGE="The task $TASK is not a valid task like apt update or apt upgrade"
else
  COLOR="0x43B581"
fi

./discord.sh --webhook-url "$WEBHOOK_URL" \
  --username "$(hostname)" \
  --description "" \
  --field "$TASK;$MESSAGE" \
  --timestamp \
  --color "$COLOR" \
  --footer "$(hostname -i)"

exit


#!/bin/bash
#UPDATE_RESULT=$(apt update)
#MESSAGE=""

#IFS=$'\n'
#for line in $UPDATE_RESULT; do
#  MESSAGE+="\n$line"
#done

#./discord.sh --webhook-url "$WEBHOOK_URL" \
#   --username "$(hostname)" \
#   --description "" \
#   --field "apt update;$MESSAGE" \
#   --timestamp \
#   --color "0xFFFFFF" \
#   --footer "$(hostname -i)"

# exit