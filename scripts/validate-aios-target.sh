#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

require_file() {
  local path="$1"
  if [[ ! -f "${ROOT_DIR}/${path}" ]]; then
    echo "missing required file: ${path}" >&2
    exit 1
  fi
}

require_executable() {
  local path="$1"
  require_file "${path}"
  if [[ ! -x "${ROOT_DIR}/${path}" ]]; then
    echo "required tool is not executable: ${path}" >&2
    exit 1
  fi
}

require_file "packages/target-aios-gui/package.toml"
require_file "packages/target-aios-gui/README.md"
require_executable "packages/target-aios-gui/tools/qemu"
require_executable "packages/target-aios-gui/tools/aios"
require_file "packages/target-aios-gui/buildroot/configs/aios_gui_x86_64_defconfig"
require_file "packages/target-aios-gui/buildroot/configs/aios_gui_aarch64_defconfig"
require_file "packages/target-aios-gui/buildroot/kernel/aios_gui_x86_64.fragment"
require_file "packages/target-aios-gui/buildroot/kernel/aios_gui_aarch64.fragment"
require_file "packages/target-aios-gui/buildroot/overlays/rootfs/init"

require_file "packages/target-aios-service/package.toml"
require_executable "packages/target-aios-service/tools/qemu"

sh -n "${ROOT_DIR}/packages/target-aios-gui/tools/qemu"
sh -n "${ROOT_DIR}/packages/target-aios-gui/tools/aios"
sh -n "${ROOT_DIR}/packages/target-aios-service/tools/qemu"

if ! grep -q 'types = .*"target"' "${ROOT_DIR}/packages/target-aios-gui/package.toml"; then
  echo "target-aios-gui package.toml must declare target type" >&2
  exit 1
fi

if ! grep -q 'types = .*"target"' "${ROOT_DIR}/packages/target-aios-service/package.toml"; then
  echo "target-aios-service package.toml must declare target type" >&2
  exit 1
fi

echo "aios target validation: PASS"
