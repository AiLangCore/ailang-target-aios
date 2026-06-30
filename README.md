# AiLang AiOS Target

This repository contains the official AiOS target packages for AiLang.

AiOS is a shell-less Linux-based target profile for running AiLang applications
directly as the system experience.

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

## Display Backends

AiOS GUI supports:

- DRM/KMS through `/dev/dri/card0`
- framebuffer fallback through `/dev/fb0`

The normal Linux desktop AiVectra host remains separate and is not replaced by
the AiOS backend.

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
