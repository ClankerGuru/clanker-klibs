# Clanker KLibs

[![Build](https://github.com/ClankerGuru/clanker-klibs/actions/workflows/build.yml/badge.svg)](https://github.com/ClankerGuru/clanker-klibs/actions/workflows/build.yml)
[![Kotlin](https://img.shields.io/badge/Kotlin-2.3.0-7F52FF.svg?logo=kotlin)](https://kotlinlang.org)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

[![kotlinx-coroutines](https://img.shields.io/badge/kotlinx--coroutines-1.10.1-blue)](https://github.com/Kotlin/kotlinx.coroutines)
[![kotlinx-io](https://img.shields.io/badge/kotlinx--io-0.9.0-blue)](https://github.com/Kotlin/kotlinx-io)
[![kotlinx-datetime](https://img.shields.io/badge/kotlinx--datetime-0.7.0-blue)](https://github.com/Kotlin/kotlinx-datetime)
[![kotlinx-serialization](https://img.shields.io/badge/kotlinx--serialization-1.10.0-blue)](https://github.com/Kotlin/kotlinx.serialization)
[![atomicfu](https://img.shields.io/badge/atomicfu-0.27.0-blue)](https://github.com/Kotlin/kotlinx-atomicfu)
[![ktor](https://img.shields.io/badge/ktor-3.1.0-blue)](https://github.com/ktorio/ktor)
[![wgpu4k](https://img.shields.io/badge/wgpu4k-27.0.4-blue)](https://github.com/wgpu4k/wgpu4k-native)

Pre-built Kotlin/Native libraries for **Kotlin 2.3.0**, used by [Clanker](https://github.com/ClankerGuru/clanker).

These are temporary patches until upstream libraries officially support Kotlin 2.3.0.

## Libraries

| Library | Version | Tag | Modules |
|---------|---------|-----|---------|
| [kotlinx-coroutines](https://github.com/Kotlin/kotlinx.coroutines) | 1.10.1-SNAPSHOT | `1.10.1` | core |
| [kotlinx-io](https://github.com/Kotlin/kotlinx-io) | 0.9.0-SNAPSHOT | `0.8.2` | core |
| [kotlinx-datetime](https://github.com/Kotlin/kotlinx-datetime) | 0.7.0-SNAPSHOT | `v0.7.0` | datetime |
| [kotlinx-serialization](https://github.com/Kotlin/kotlinx.serialization) | 1.10.0-SNAPSHOT | `v1.10.0-RC` | core, json |
| [atomicfu](https://github.com/Kotlin/kotlinx-atomicfu) | 0.27.0-SNAPSHOT | `0.27.0` | atomicfu |
| [ktor](https://github.com/ktorio/ktor) | 3.1.0 | `3.1.0` | client, server, all modules |
| [wgpu4k](https://github.com/wgpu4k/wgpu4k-native) | v27.0.4-SNAPSHOT | `v27.0.4` | native |

## Platforms

- **macOS ARM64** (`macosarm64`)
- **Linux x64** (`linuxx64`)

## Download

### With Clanker CLI

```bash
clk deps
```

Downloads all klibs to `~/.clanker/deps/<platform>/`

### Manual Download

Pre-built `.klib` files are available from [Releases](https://github.com/ClankerGuru/clanker-klibs/releases).

```bash
# Download all klibs for your platform
gh release download v1.0.0 --repo ClankerGuru/clanker-klibs --pattern '*linuxx64*'
```

## Build from Source

```bash
git clone https://github.com/ClankerGuru/clanker-klibs.git
cd clanker-klibs

./build.sh list                    # List libraries
./build.sh clone                   # Clone and patch all
TARGET=linuxX64 ./build.sh build serialization  # Build specific lib
TARGET=macosArm64 ./build.sh all   # Build all for target
```

## CI

The GitHub Actions workflow automatically builds serialization (core + json) for linuxX64 on push to main.

## Acknowledgments

Thanks to the maintainers of these projects:

- **JetBrains Kotlin Team** for kotlinx-* libraries
- **Ktor Team** for Ktor
- **wgpu4k Contributors** for wgpu4k

## License

Patches are provided under the same license as their upstream libraries (Apache 2.0).
