#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${SCRIPT_DIR}
ROOT_DIR="$(cd .. && pwd)"
cd ${ROOT_DIR}

err_exit() {
  exit -1; 
}

set -x
pwd

build_it()
{
acpu=$1

OUTDIR=out/mac_${acpu}
# -- below is some extra config may be can added to args_val
#  treat_warnings_as_errors = false
args_val=' target_os = "mac" is_debug = false '
gn gen --ide=xcode --workspace=all_helloworld --args="${args_val} target_cpu=\"${acpu}\"" ${OUTDIR} || err_exit
ninja -vvC ${OUTDIR}

}


build_it x64
build_it x86

