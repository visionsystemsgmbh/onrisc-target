#!/bin/sh

BOARD_DIR="$(pwd)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-barebox-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BOARD_DIR}/../genimage.tmp"

rm -rf "${GENIMAGE_TMP}"

genimage                           \
	--rootpath "${BOARD_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BOARD_DIR}"  \
	--outputpath "${BOARD_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
