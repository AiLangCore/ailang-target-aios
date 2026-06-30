# AiLang AiOS Target

This repository contains the official AiOS target packages for AiLang.

AiOS is a shell-less Linux-based target profile for running AiLang applications
directly as the system experience.

Current package release: `0.0.1-alpha.5`.

## Packages

```text
packages/target-aios-service
packages/target-aios-gui
```

`target-aios-service` is the headless service/server profile.

`target-aios-gui` is the AiVectra GUI profile. It boots a Linux kernel and
initramfs, then launches the AiLang/AiVectra app instead of a shell.

## Profiles

AiOS profiles live in this repository rather than separate repositories per
board:

```text
profiles/qemu
profiles/rpi
profiles/pi3bplus
profiles/pi4
profiles/pi5
```

The initial fully exercised profile is `qemu`. Board profiles are added as
target-owned profile modules over the same package contract.

## Target Contract

AiLang remains generic:

```bash
ailang run . --target aios-gui
ailang publish . --target aios-gui --type img
ailang flash . --target aios-gui
ailang doctor --target aios-gui
```

The CLI resolves this repository through the package registry and invokes the
target-owned tools declared by package metadata.

The QEMU profile supports both x86_64 and aarch64:

```bash
ailang run . --target aios-gui --target-option arch=aarch64
```

Additional QEMU arguments can be passed after `--`:

```bash
ailang run . \
  --target aios-gui \
  --target-option arch=aarch64 \
  --target-option feature=network \
  --target-option display-backend=drm \
  -- \
  -m 2048 \
  -device virtio-gpu-pci \
  -device qemu-xhci,id=xhci \
  -device usb-kbd,bus=xhci.0 \
  -device usb-tablet,bus=xhci.0 \
  -display cocoa
```

## Base Images

AiOS uses reusable Buildroot base images. The target package version and base
image version are intentionally separate.

`target-aios-gui` `0.0.1-alpha.5` currently defaults to the compatible
Buildroot base image `0.0.1-alpha.1`. This allows target tooling fixes to ship
without forcing every developer to rebuild the Linux base.

Buildroot base creation requires a Linux build host:

```bash
ailang aios build-base --target aios-gui --version 0.0.1-alpha.1 --arch aarch64
```

macOS and Windows development hosts consume an existing cached or imported base
image when running or publishing:

```bash
ailang publish . \
  --target aios-gui \
  --target-option arch=aarch64 \
  --target-option base-version=0.0.1-alpha.1
```

## Display Backends

AiOS GUI supports:

- DRM/KMS through `/dev/dri/card0`
- framebuffer fallback through `/dev/fb0`

The normal Linux desktop AiVectra host remains separate and is not replaced by
the AiOS backend.

The display backend can be selected with:

```bash
ailang run . \
  --target aios-gui \
  --target-option display-backend=drm
```

## Verification

```bash
./scripts/validate-aios-target.sh
```

This checks package descriptors, shell syntax, and required target files.

## Registry

The curated registry entry lives in:

```text
AiLangCore/ailang-packages
```

Registry records must point at immutable commits in this repository.
