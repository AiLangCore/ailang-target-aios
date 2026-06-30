# AiOS Target Agents

This repository owns the official AiLang AiOS target packages.

## Ownership

AiOS owns:

- `target-aios-gui`
- `target-aios-service`
- AiOS QEMU runners
- AiOS base image tooling
- AiOS Buildroot defconfigs and kernel fragments
- AiOS host integration packaging
- AiOS profiles such as `qemu`, `rpi`, `pi3bplus`, `pi4`, and `pi5`

AiOS does not own:

- AiLang language semantics
- compiler behavior
- validation rules
- AiVM evaluation semantics
- AiVectra UI semantics
- hardware-specific APIs such as GPIO, I2C, SPI, camera, or touch

Hardware APIs belong in optional capability packages that consume target
capabilities.

## Layout

```text
packages/
  target-aios-gui/
  target-aios-service/
profiles/
scripts/
SPEC/
tests/
```

## Rules

- Keep target behavior package-driven. Do not add platform-specific target ids
  to the AiLang CLI.
- Host/runtime changes must remain mechanical and must not introduce language,
  package, UI, parsing, validation, formatting, or application semantics.
- Prefer focused `.aos` modules and small shell tools over large monolithic
  target scripts.
- Buildroot bases are reusable target artifacts. Normal app publish/run must
  consume cached bases instead of rebuilding Buildroot every time.
- `qemu` is the reference development profile. Board profiles should share the
  same target contract and override only hardware/profile specifics.
- IMPORTANT: Until a major or minor release is officially released, all
  contracts, APIs, schemas, interfaces, and architectural decisions are
  considered negotiable and may change freely. Do not add backward
  compatibility layers, legacy adapters, or dual-path support unless explicitly
  requested. When changing direction, replace the old implementation completely
  and update the codebase consistently to the new contract. Patch releases are
  for bug fixes only.

## Verification

```bash
./scripts/validate-aios-target.sh
```
