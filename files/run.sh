#!/usr/bin/env bash
set -e -o pipefail

ADDITIONAL_ARGUMENTS=()
if [[ "$FORWARD_DIRECTION" == remote ]]; then
    ADDITIONAL_ARGUMENTS+=( -L )
elif [[ "$FORWARD_DIRECTION" == local ]]; then
    ADDITIONAL_ARGUMENTS+=( -R )
else
    echo "Invalid FORWARD_DIRECTION: \"${FORWARD_DIRECTION}\""
    exit 1
fi
ADDITIONAL_ARGUMENTS+=("${SOURCE_ADDRESS}:${TARGET_ADDRESS}")

if [[ -n "$SERVER_IDENTITY" ]]; then
    echo "* $SERVER_IDENTITY" > /dev/shm/known_hosts
else
    touch /dev/shm/known_hosts
    echo "No SERVER_IDENTITY provided. Host key won't be verified."
fi

echo "$SERVER_KEY" > /dev/shm/ssh-key
chmod 600 /dev/shm/known_hosts /dev/shm/ssh-key

ssh "${ADDITIONAL_ARGUMENTS[@]}" -i /dev/shm/ssh-key -N -o ExitOnForwardFailure=yes \
    -o LogLevel=VERBOSE -o ServerAliveCountMax=3 -o ServerAliveInterval=15 \
    -o StrictHostKeyChecking=accept-new -o UserKnownHostsFile=/dev/shm/known_hosts "$SERVER_URL"
