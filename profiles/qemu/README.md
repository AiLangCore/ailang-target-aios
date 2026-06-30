# AiOS QEMU Profile

`qemu` is the reference AiOS development and CI profile.

It owns QEMU command-line selection, architecture-specific emulator defaults,
debug console wiring, and reusable base image validation for:

- `x86_64`
- `aarch64`

The profile must remain package-driven. The generic AiLang CLI resolves this
profile through target package metadata and must not hardcode AiOS behavior.
