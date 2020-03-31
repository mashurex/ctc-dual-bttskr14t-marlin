#!/bin/bash -eu
#PLATFORM="STM32F103RC_bigtree_512K"
PLATFORM="LPC1769"
BUILD_DIR="./.pio/build"
SRC_PATH="${BUILD_DIR}/${PLATFORM}/firmware.bin"

TARGET_PATH="/Volumes/NO NAME"
if [ "${1:-}" != "" ]; then
    TARGET_PATH="${1}"
fi

if [ ! -d "${TARGET_PATH}" ]; then
    >&2 echo "ERROR: Path '${TARGET_PATH}' is not a directory"
    exit 20
fi

TARGET_FILE="${TARGET_PATH}/firmware.bin"

if [ ! -f "${SRC_PATH}" ]; then
    >&2 echo "ERROR: No firmware file exists at ${SRC_PATH}"
    exit 30
fi

if [ -f "${TARGET_FILE}" ]; then
    echo "...Backing up previous firmware '${TARGET_FILE}'"
    mv "${TARGET_FILE}" "${TARGET_PATH}/backup_firmware.bak"
fi

if [ -f "${TARGET_PATH}/FIRMWARE.CUR" ]; then
    echo "...Backing up previous current firmware file '${TARGET_PATH}/FIRMWARE.CUR'"
    mv "${TARGET_PATH}/FIRMWARE.CUR" "${TARGET_PATH}/FIRMWARE_CUR.BAK"
fi

echo "...Copying '${SRC_PATH}' to directory '${TARGET_FILE}'"
cp "${SRC_PATH}" "${TARGET_FILE}"

echo "Done"
exit 0