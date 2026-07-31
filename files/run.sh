#!/usr/bin/env bash
set -e -o pipefail

ADDITIONAL_ARGUMENTS=()

FORWARDINGS_COUNT=0
for FORWARD_DIRECTION_VARIABLE in FORWARD_DIRECTION ${!FORWARD_DIRECTION_@}; do
    if [[ -z "${!FORWARD_DIRECTION_VARIABLE}" ]]; then
        continue
    fi

    if [[ "${!FORWARD_DIRECTION_VARIABLE}" == remote ]]; then
        ADDITIONAL_ARGUMENTS+=( -L )
    elif [[ "${!FORWARD_DIRECTION_VARIABLE}" == local ]]; then
        ADDITIONAL_ARGUMENTS+=( -R )
    else
        echo "Invalid $FORWARD_DIRECTION_VARIABLE: \"${!FORWARD_DIRECTION_VARIABLE}\""
        exit 1
    fi

    VARIABLE_SUFFIX="${FORWARD_DIRECTION_VARIABLE#FORWARD_DIRECTION}"
    SOURCE_ADDRESS_VARIABLE="SOURCE_ADDRESS${VARIABLE_SUFFIX}"
    TARGET_ADDRESS_VARIABLE="TARGET_ADDRESS${VARIABLE_SUFFIX}"
    ADDITIONAL_ARGUMENTS+=("${!SOURCE_ADDRESS_VARIABLE}:${!TARGET_ADDRESS_VARIABLE}")
    FORWARDINGS_COUNT=$((FORWARDINGS_COUNT + 1))
done

if [[ -n "$SERVER_IDENTITY" ]]; then
    echo "* $SERVER_IDENTITY" > /dev/shm/known_hosts
else
    touch /dev/shm/known_hosts
    echo "No SERVER_IDENTITY provided. Host key won't be verified."
fi

echo "$SERVER_KEY" > /dev/shm/ssh-key
chmod 600 /dev/shm/known_hosts /dev/shm/ssh-key

echo "Starting $FORWARDINGS_COUNT forwardings to \"${SERVER_URL}\""

ssh "${ADDITIONAL_ARGUMENTS[@]}" -i /dev/shm/ssh-key -N -o ExitOnForwardFailure=yes \
    -o LogLevel=VERBOSE -o ServerAliveCountMax=3 -o ServerAliveInterval=15 \
    -o StrictHostKeyChecking=accept-new -o UserKnownHostsFile=/dev/shm/known_hosts "$SERVER_URL"
