# Clanker KLibs

[![Build](https://github.com/ClankerGuru/clanker-klibs/actions/workflows/build.yml/badge.svg)](https://github.com/ClankerGuru/clanker-klibs/actions/workflows/build.yml)
[![Kotlin](https://img.shields.io/badge/Kotlin-2.3.0-7F52FF.svg?logo=kotlin)](https://kotlinlang.org)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

[![kotlinx-coroutines](https://img.shields.io/badge/kotlinx--coroutines-1.10.1-blue)](https://github.com/Kotlin/kotlinx.coroutines)
[![kotlinx-io](https://img.shields.io/badge/kotlinx--io-0.8.2-blue)](https://github.com/Kotlin/kotlinx-io)
[![kotlinx-datetime](https://img.shields.io/badge/kotlinx--datetime-0.7.0-blue)](https://github.com/Kotlin/kotlinx-datetime)
[![kotlinx-serialization](https://img.shields.io/badge/kotlinx--serialization-1.10.0--RC-blue)](https://github.com/Kotlin/kotlinx.serialization)
[![atomicfu](https://img.shields.io/badge/atomicfu-0.27.0-blue)](https://github.com/Kotlin/kotlinx-atomicfu)
[![ktor](https://img.shields.io/badge/ktor-3.1.0-blue)](https://github.com/ktorio/ktor)
[![wgpu4k](https://img.shields.io/badge/wgpu4k-27.0.4-blue)](https://github.com/wgpu4k/wgpu4k-native)

Pre-built Kotlin/Native libraries for **Kotlin 2.3.0**, used by [Clanker](https://github.com/ClankerGuru/clanker).

These are temporary patches until upstream libraries officially support Kotlin 2.3.0.

## Libraries

| Library | Version | Tag | Patches |
|---------|---------|-----|---------|
| [kotlinx-coroutines](https://github.com/Kotlin/kotlinx.coroutines) | 1.10.1 | [`1.10.1`](https://github.com/Kotlin/kotlinx.coroutines/tree/1.10.1) | Gradle DSL migration |
| [kotlinx-io](https://github.com/Kotlin/kotlinx-io) | 0.8.2 | [`0.8.2`](https://github.com/Kotlin/kotlinx-io/tree/0.8.2) | Gradle DSL migration |
| [kotlinx-datetime](https://github.com/Kotlin/kotlinx-datetime) | 0.7.0 | [`v0.7.0`](https://github.com/Kotlin/kotlinx-datetime/tree/v0.7.0) | Gradle DSL migration |
| [kotlinx-serialization](https://github.com/Kotlin/kotlinx.serialization) | 1.10.0-RC | [`v1.10.0-RC`](https://github.com/Kotlin/kotlinx.serialization/tree/v1.10.0-RC) | None needed |
| [atomicfu](https://github.com/Kotlin/kotlinx-atomicfu) | 0.27.0 | [`0.27.0`](https://github.com/Kotlin/kotlinx-atomicfu/tree/0.27.0) | Gradle DSL, Develocity |
| [ktor](https://github.com/ktorio/ktor) | 3.1.0 | [`3.1.0`](https://github.com/ktorio/ktor/tree/3.1.0) | Gradle DSL migration |
| [wgpu4k](https://github.com/wgpu4k/wgpu4k-native) | 27.0.4 | [`v27.0.4`](https://github.com/wgpu4k/wgpu4k-native/tree/v27.0.4) | @OptionalExpectation, native-only |

## Download

Pre-built `.klib` files are available from [Releases](https://github.com/ClankerGuru/clanker-klibs/releases).

```bash
# Download a specific library
curl -LO https://github.com/ClankerGuru/clanker-klibs/releases/download/v1.0.0/kotlinx-coroutines-core-macosarm64.klib

# Or download all klibs for your platform
curl -s https://api.github.com/repos/ClankerGuru/clanker-klibs/releases/latest \
  | grep "browser_download_url.*macosarm64.klib" \
  | cut -d '"' -f 4 \
  | xargs -n1 curl -LO
```

## Usage with Clanker

These libraries are automatically used by [Clanker](https://github.com/ClankerGuru/clanker) when building Kotlin/Native projects with Kotlin 2.3.0.

Place the `.klib` files in your Clanker deps directory:

```bash
~/.clanker/deps/macosarm64/
├── kotlinx-coroutines-core.klib
├── kotlinx-io-core.klib
├── kotlinx-datetime.klib
├── kotlinx-serialization-core.klib
├── atomicfu.klib
└── ktor-*.klib
```

## Build from Source

```bash
git clone https://github.com/ClankerGuru/clanker-klibs.git
cd clanker-klibs

./build.sh list                    # List libraries
./build.sh clone                   # Clone and patch all
TARGET=macosArm64 ./build.sh all   # Build all for target
```

## Supported Targets

- **macOS**: macosArm64
- **Linux**: linuxX64

More targets coming soon.

## Acknowledgments

Huge thanks to the maintainers and contributors of these incredible projects:

- **JetBrains Kotlin Team** for [kotlinx-coroutines](https://github.com/Kotlin/kotlinx.coroutines), [kotlinx-io](https://github.com/Kotlin/kotlinx-io), [kotlinx-datetime](https://github.com/Kotlin/kotlinx-datetime), [kotlinx-serialization](https://github.com/Kotlin/kotlinx.serialization), and [atomicfu](https://github.com/Kotlin/kotlinx-atomicfu)
- **Ktor Team** for [Ktor](https://github.com/ktorio/ktor)
- **wgpu4k Contributors** for [wgpu4k](https://github.com/wgpu4k/wgpu4k-native)

These libraries make Kotlin/Native development possible. We're just patching them temporarily until official Kotlin 2.3.0 support lands.

## License

Patches are provided under the same license as their upstream libraries (Apache 2.0).
