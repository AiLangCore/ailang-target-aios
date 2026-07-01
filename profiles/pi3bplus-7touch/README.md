# AiOS Raspberry Pi 3B+ 7-Inch Touch Profile

This is the first hardware bring-up profile for the test device:

```text
Raspberry Pi 3B/3B+
Official Raspberry Pi 7-inch DSI touchscreen
Ethernet networking
```

Buildroot base:

```text
raspberrypi3_64_defconfig
```

Additional kernel fragment:

```text
packages/target-aios-gui/buildroot/kernel/aios_gui_pi3bplus_7touch.fragment
```

The fragment enables:

```text
CONFIG_DRM_VC4
CONFIG_DRM_MIPI_DSI
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN
CONFIG_TOUCHSCREEN_RASPBERRYPI_FW
CONFIG_INPUT_EVDEV
```

That is the target-level hardware path for the official DSI display and
`raspberrypi-ts` touch events. AiVectra still owns UI input semantics above
evdev.

Build on Linux:

```sh
ailang aios build-base \
  --target aios-gui \
  --version 0.0.1-alpha.1 \
  --arch aarch64 \
  --profile pi3bplus-7touch
```

Publish an app image on Linux:

```sh
ailang publish . \
  --target aios-gui \
  --target-option arch=aarch64 \
  --target-option profile=pi3bplus-7touch \
  --target-option base-version=0.0.1-alpha.1 \
  --out dist-aios
```
