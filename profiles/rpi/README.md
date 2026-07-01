# AiOS Raspberry Pi Profile

Shared Raspberry Pi AiOS profile behavior.

Board-specific profiles such as `pi3bplus`, `pi4`, and `pi5` should override
only hardware-specific boot, image, and deployment details.

Raspberry Pi profiles produce SD-card images instead of QEMU `-kernel`
initramfs artifacts.
