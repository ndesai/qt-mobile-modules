#!/usr/bin/env bash

set -e

DIR_QT="/Users/niraj/SDK/5.12.10"

DIR_SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DIR_SOURCE="$DIR_SCRIPT/../"
DIR_BUILD="$PWD"

ARGPARSE_DESCRIPTION="Build qt-mobile-modules"      # this is optional
source "${DIR_SCRIPT}/argparse.bash" || exit 1
argparse "$@" <<EOF || exit 1
parser.add_argument('-b', '--build-type', default='release', nargs='?',
                    choices=['debug', 'release'],
                    help='Build type')
parser.add_argument('-p', '--platform', default='ios', nargs='?',
                    choices=['ios', 'macos', "android"],
                    help='Build type')
parser.add_argument('--qt', action='store', type=str, 
                    default="${DIR_QT}",
                    help='The text to parse.')
EOF

DIR_QT_ios="${DIR_QT}/ios"
DIR_QT_androidv8a="${DIR_QT}/android_arm64_v8a"
DIR_QT_androidv8a="${DIR_QT}/android_armv7"
DIR_QT_clang64="${DIR_QT}/clang_64"

CMD_QMAKE=""
QMAKE_SPEC=""
CMD_EXTRA=""
if [[ "${PLATFORM}" == "ios" ]]; then
    CMD_QMAKE="${DIR_QT_ios}/bin/qmake"
    QMAKE_SPEC="macx-ios-clang"
    CMD_EXTRA="CONFIG+=iphonesimulator CONFIG+=simulator"
elif [[ "${PLATFORM}" == "macos" ]]; then
    CMD_QMAKE="${DIR_QT_clang64}/bin/qmake"
fi

DIR_INSTALL="${DIR_BUILD}/install"
mkdir -p "${DIR_INSTALL}"
$CMD_QMAKE \
    PREFIX="${DIR_INSTALL}" \
    CONFIG+="${BUILD_TYPE}" \
    -spec "${QMAKE_SPEC}" \
    ${CMD_EXTRA} "${DIR_SOURCE}"/
make -j4 install
