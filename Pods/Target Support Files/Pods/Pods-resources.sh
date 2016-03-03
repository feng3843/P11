#!/bin/sh
set -e

mkdir -p "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

realpath() {
  DIRECTORY="$(cd "${1%/*}" && pwd)"
  FILENAME="${1##*/}"
  echo "$DIRECTORY/$FILENAME"
}

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1"`.mom\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcmappingmodel`.cdm\""
      xcrun mapc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE=$(realpath "${PODS_ROOT}/$1")
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    /*)
      echo "$1"
      echo "$1" >> "$RESOURCES_TO_COPY"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerChecked.imageset/CTAssetsPickerChecked.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerChecked.imageset/CTAssetsPickerChecked@2x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerChecked.imageset/CTAssetsPickerChecked@3x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerEmptyAsset.imageset/CTAssetsPickerEmptyAsset.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerEmptyAsset.imageset/CTAssetsPickerEmptyAsset@2x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerEmptyAsset.imageset/CTAssetsPickerEmptyAsset@3x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerEmptyCell.imageset/CTAssetsPickerEmptyCell.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerEmptyCell.imageset/CTAssetsPickerEmptyCell@2x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerEmptyCell.imageset/CTAssetsPickerEmptyCell@3x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerLocked.imageset/UIAccessDeniedViewLock.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerLocked.imageset/UIAccessDeniedViewLock@2x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerLocked.imageset/UIAccessDeniedViewLock@3x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerPlay.imageset/CTAssetsPickerPlay.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerPlay.imageset/CTAssetsPickerPlay@2x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerPlay.imageset/CTAssetsPickerPlay@3x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerVideo.imageset/CTAssetsPickerVideo.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerVideo.imageset/CTAssetsPickerVideo@2x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerVideo.imageset/CTAssetsPickerVideo@3x.png"
  install_resource "KOKeyboard/KOKeyboard/hal-black.png"
  install_resource "KOKeyboard/KOKeyboard/hal-black@2x.png"
  install_resource "KOKeyboard/KOKeyboard/hal-blue.png"
  install_resource "KOKeyboard/KOKeyboard/hal-blue@2x.png"
  install_resource "KOKeyboard/KOKeyboard/hal-white.png"
  install_resource "KOKeyboard/KOKeyboard/hal-white@2x.png"
  install_resource "KOKeyboard/KOKeyboard/key-blue.png"
  install_resource "KOKeyboard/KOKeyboard/key-blue@2x.png"
  install_resource "KOKeyboard/KOKeyboard/key-pressed.png"
  install_resource "KOKeyboard/KOKeyboard/key-pressed@2x.png"
  install_resource "KOKeyboard/KOKeyboard/key.png"
  install_resource "KOKeyboard/KOKeyboard/key@2x.png"
  install_resource "NSDate+TimeAgo/NSDateTimeAgo.bundle"
  install_resource "PaperFold/PaperFold/PaperFold/PaperFold/PaperFoldResources.bundle/swipe_guide_left.png"
  install_resource "PaperFold/PaperFold/PaperFold/PaperFold/PaperFoldResources.bundle/swipe_guide_left@2x.png"
  install_resource "PaperFold/PaperFold/PaperFold/PaperFold/PaperFoldResources.bundle/swipe_guide_right.png"
  install_resource "PaperFold/PaperFold/PaperFold/PaperFold/PaperFoldResources.bundle/swipe_guide_right@2x.png"
  install_resource "SVProgressHUD/SVProgressHUD/SVProgressHUD.bundle"
  install_resource "iOS-Slide-Menu/SlideMenu/Source/Assets/menu-button.png"
  install_resource "iOS-Slide-Menu/SlideMenu/Source/Assets/menu-button@2x.png"
  install_resource "uikit-utils/Resources/delete_button.png"
  install_resource "uikit-utils/Resources/delete_button@2x.png"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerChecked.imageset/CTAssetsPickerChecked.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerChecked.imageset/CTAssetsPickerChecked@2x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerChecked.imageset/CTAssetsPickerChecked@3x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerEmptyAsset.imageset/CTAssetsPickerEmptyAsset.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerEmptyAsset.imageset/CTAssetsPickerEmptyAsset@2x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerEmptyAsset.imageset/CTAssetsPickerEmptyAsset@3x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerEmptyCell.imageset/CTAssetsPickerEmptyCell.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerEmptyCell.imageset/CTAssetsPickerEmptyCell@2x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerEmptyCell.imageset/CTAssetsPickerEmptyCell@3x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerLocked.imageset/UIAccessDeniedViewLock.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerLocked.imageset/UIAccessDeniedViewLock@2x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerLocked.imageset/UIAccessDeniedViewLock@3x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerPlay.imageset/CTAssetsPickerPlay.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerPlay.imageset/CTAssetsPickerPlay@2x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerPlay.imageset/CTAssetsPickerPlay@3x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerVideo.imageset/CTAssetsPickerVideo.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerVideo.imageset/CTAssetsPickerVideo@2x.png"
  install_resource "CTAssetsPickerController/CTAssetsPickerController/CTAssetsPicker.xcassets/CTAssetsPickerVideo.imageset/CTAssetsPickerVideo@3x.png"
  install_resource "KOKeyboard/KOKeyboard/hal-black.png"
  install_resource "KOKeyboard/KOKeyboard/hal-black@2x.png"
  install_resource "KOKeyboard/KOKeyboard/hal-blue.png"
  install_resource "KOKeyboard/KOKeyboard/hal-blue@2x.png"
  install_resource "KOKeyboard/KOKeyboard/hal-white.png"
  install_resource "KOKeyboard/KOKeyboard/hal-white@2x.png"
  install_resource "KOKeyboard/KOKeyboard/key-blue.png"
  install_resource "KOKeyboard/KOKeyboard/key-blue@2x.png"
  install_resource "KOKeyboard/KOKeyboard/key-pressed.png"
  install_resource "KOKeyboard/KOKeyboard/key-pressed@2x.png"
  install_resource "KOKeyboard/KOKeyboard/key.png"
  install_resource "KOKeyboard/KOKeyboard/key@2x.png"
  install_resource "NSDate+TimeAgo/NSDateTimeAgo.bundle"
  install_resource "PaperFold/PaperFold/PaperFold/PaperFold/PaperFoldResources.bundle/swipe_guide_left.png"
  install_resource "PaperFold/PaperFold/PaperFold/PaperFold/PaperFoldResources.bundle/swipe_guide_left@2x.png"
  install_resource "PaperFold/PaperFold/PaperFold/PaperFold/PaperFoldResources.bundle/swipe_guide_right.png"
  install_resource "PaperFold/PaperFold/PaperFold/PaperFold/PaperFoldResources.bundle/swipe_guide_right@2x.png"
  install_resource "SVProgressHUD/SVProgressHUD/SVProgressHUD.bundle"
  install_resource "iOS-Slide-Menu/SlideMenu/Source/Assets/menu-button.png"
  install_resource "iOS-Slide-Menu/SlideMenu/Source/Assets/menu-button@2x.png"
  install_resource "uikit-utils/Resources/delete_button.png"
  install_resource "uikit-utils/Resources/delete_button@2x.png"
fi

mkdir -p "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]]; then
  mkdir -p "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "$XCASSET_FILES" ]
then
  case "${TARGETED_DEVICE_FAMILY}" in
    1,2)
      TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
      ;;
    1)
      TARGET_DEVICE_ARGS="--target-device iphone"
      ;;
    2)
      TARGET_DEVICE_ARGS="--target-device ipad"
      ;;
    *)
      TARGET_DEVICE_ARGS="--target-device mac"
      ;;
  esac

  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "`realpath $PODS_ROOT`*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${IPHONEOS_DEPLOYMENT_TARGET}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi