#!/usr/bin/env bash
set -e
RECIPIENT=$1
test -n "$RECIPIENT" || (echo "Recipient cannot be empty!"; exit 1)
gpg --quiet --list-keys "$RECIPIENT" 2>&1 > /dev/null || (echo "Key not found"; exit 2)
2>&1 echo "Pipe in message, or paste and it ctrl-d when done"
MESSAGE=$(cat)
2>&1 echo -e "---BEGIN MESSAGE----\n$MESSAGE\n---END MESSAGE---\n"
read -p "Is this OK? (Y/n): " CONFIRM
if [ "$CONFIRM" = "Y" ]; then
    echo -e "$MESSAGE" | gpg --trust-model always --quiet --recipient $RECIPIENT --encrypt --armor
    exit 0
fi
exit 1
