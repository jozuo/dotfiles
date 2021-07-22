#!/usr/bin/env bash
set -Ceuo pipefail
cd `dirname $0`

AIR_PODS_ADDRESS=60-83-73-bf-b4-65

if [ `uname -m` = "arm64" ]; then
    CMD_PATH=/opt/homebrew/bin
else
    CMD_PATH=/usr/local/bin
fi

${CMD_PATH}/BluetoothConnector -c $AIR_PODS_ADDRESS
for ((i=0 ; i<10 ; i++))
do
    if [ "Connected" == $(${CMD_PATH}/BluetoothConnector  -s ${AIR_PODS_ADDRESS}) ]; then
        sleep 0.5
        ${CMD_PATH}/SwitchAudioSource -u ${AIR_PODS_ADDRESS}
        sleep 0.5 
        say -v samantha Connected
        break
    fi
    sleep 1
done
