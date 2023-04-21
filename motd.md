
remove stuff from motd
- echo ! > /etc/motd
remove other motd files
- rm /etc/update-motd.d/*
create custom motd, past in your ASCII
- sudo nano /etc/update-motd.d/1-buurmanslogin
make it executable
- sudo chmod +x /etc/update-motd.d/1-BuurmanLoginText
`

#!/bin/bash

# Define the colors in the rainbow
colors=("226" "214" "203" "198" "165" "47" "51" "39" "141" "129")


# Define your ASCII art here
art="
******************************************************
*      .-.   .-.      .-.  .-.                       *
*      : :.-.: :      : :  : :.-.                    *
*      : :: :: : .--. : :  : \`'.' .--. ,-.,-.,-.     *
*      : \`' \`' ;' '_.': :_ : . \`.' .; :: ,. ,. :     *
*       \`.,\`.,' \`.__.'\`.__;:_;:_;\`.__.':_;:_;:_;     *
*                   .-.    _  _                      *
*                   : :   :_;:_;                     *
*                   : \`-. .-..-.                     *
*                   ' .; :: :: :                     *
*                   \`.__.':_;: :                     *
* .---.                    .-. :                     *
* : .; :                  \`._.'                      *
* :   .'.-..-..-..-..--. ,-.,-.,-. .--.  ,-.,-. .--. *
* : .; :: :; :: :; :: ..': ,. ,. :' .; ; : ,. :\`._-.'*
* :___.'\`.__.'\`.__.':_;  :_;:_;:_;\`.__,_;:_;:_;\`.__.'*
*                                                    *
******************************************************
"

# Split the art into lines
IFS=$'\n' read -d '' -ra lines <<< "$art"

# Loop through each line and colorize it
for i in "${!lines[@]}"; do
    color_index=$((i % ${#colors[@]}))
    color_code=${colors[$color_index]}
    echo -e "\e[38;5;${color_code}m${lines[$i]}\e[0m"
done

```