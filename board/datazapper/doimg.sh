#!/bin/bash -e

version=`cat board/datazapper/version.txt`

cp "board/datazapper/grub.cfg"                "${BINARIES_DIR}/grub.cfg"    || exit 1
cp "board/datazapper/bootx64.efi"             "${BINARIES_DIR}/bootx64.efi" || exit 1
#cp "${HOST_DIR}/lib/grub/i386-pc/boot.img" "${BINARIES_DIR}/boot.img"    || exit 1
cp "output/target/lib/grub/i386-pc/boot.img" "${BINARIES_DIR}/boot.img"    || exit 1

# copy the DataZapper icon and Windows autorun.inf; if a USB stick is plugged into a Windows system
# it will be identified as 'DataZapper - Dangerous' as a warning to users unaware what DataZapper is.
cp "board/datazapper/autorun.inf"             "${BINARIES_DIR}/autorun.inf" || exit 1
cp "board/datazapper/README.txt"              "${BINARIES_DIR}/README.txt"  || exit 1
cp "board/datazapper/DataZapper.ico"             "${BINARIES_DIR}/DataZapper.ico" || exit 1

rm -rf "${BUILD_DIR}/genimage.tmp"                                       || exit 1
genimage --rootpath="${TARGET_DIR}" --inputpath="${BINARIES_DIR}" --outputpath="${BINARIES_DIR}" --config="board/datazapper/genimage.cfg" --tmppath="${BUILD_DIR}/genimage.tmp" || exit 1

# renaming
SUFFIXIMG="${version}_$(date +%Y%m%d)"
FINAL_IMAGE_PATH="${BINARIES_DIR}/shredos-${SUFFIXIMG}.img"
mv "${BINARIES_DIR}/shredos.img" "${FINAL_IMAGE_PATH}" || exit 1
#mv "${BINARIES_DIR}/bzImage" "${FINAL_IMAGE_PATH}" || exit 1

echo "File ${FINAL_IMAGE_PATH} created successfully"

exit 0
