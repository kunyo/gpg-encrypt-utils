#!/usr/bin/env bash
set -e
KEY_FINGERPRINT=$1
1>&2 echo "Pipe in message, or paste and it ctrl-d when done"
MESSAGE=$(cat)
1>&2 echo -e "$MESSAGE"
echo -e "$MESSAGE" | gpg --decrypt -u "$KEY_FINGERPRINT"
if [ $? -ne 0 ]; then
    1>&2 echo "Decryption failed"
    exit 1
fi
exit 0
