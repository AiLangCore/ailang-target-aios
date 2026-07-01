# AiOS Raspberry Pi 3B+ Profile

Raspberry Pi 3B and 3B+ AiOS image profile.

Buildroot base:

```text
raspberrypi3_64_defconfig
```

Build on Linux:

```sh
ailang aios build-base \
  --target aios-gui \
  --version 0.0.1-alpha.1 \
  --arch aarch64 \
  --profile pi3bplus
```

The base artifact is cached as:

```text
$AIOS_CACHE_ROOT/base/aios-gui/0.0.1-alpha.1/pi3bplus/aarch64/sdcard.img
```
