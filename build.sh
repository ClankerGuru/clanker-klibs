#!/bin/bash
set -euo pipefail

# Clanker KLibs - Patched Kotlin libraries for Kotlin 2.3.0
# Usage: ./build.sh [library] [--publish]

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEPS_DIR="${DEPS_DIR:-$HOME/.clanker/deps}"
TARGET="${TARGET:-macosArm64}"

# Capitalize first letter (bash 3 compatible)
capitalize() {
    echo "$(echo "${1:0:1}" | tr '[:lower:]' '[:upper:]')${1:1}"
}

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[clanker-klibs]${NC} $1"; }
warn() { echo -e "${YELLOW}[clanker-klibs]${NC} $1"; }
error() { echo -e "${RED}[clanker-klibs]${NC} $1" >&2; }

# Parse upstream.txt
parse_upstream() {
    local lib=$1
    local file="$SCRIPT_DIR/$lib/upstream.txt"
    if [[ ! -f "$file" ]]; then
        error "No upstream.txt for $lib"
        return 1
    fi

    UPSTREAM_URL=$(head -1 "$file")
    UPSTREAM_TAG=$(sed -n '2p' "$file" | sed 's/tag: //')
}

# Clone and patch a library
clone_and_patch() {
    local lib=$1
    parse_upstream "$lib"

    local dest="$DEPS_DIR/$lib"
    local patch_dir="$SCRIPT_DIR/$lib/patches"

    log "Processing $lib (tag: $UPSTREAM_TAG)"

    # Clone if not exists
    if [[ ! -d "$dest" ]]; then
        log "Cloning $UPSTREAM_URL..."
        git clone --depth 1 --branch "$UPSTREAM_TAG" "$UPSTREAM_URL" "$dest"
    else
        log "Using existing clone at $dest"
    fi

    # Apply patches
    if [[ -d "$patch_dir" ]]; then
        for patch in "$patch_dir"/*.patch; do
            if [[ -f "$patch" ]]; then
                log "Applying $(basename "$patch")..."
                (cd "$dest" && git apply "$patch" 2>/dev/null || git apply --3way "$patch" || warn "Patch may already be applied")
            fi
        done
    fi
}

# Build a library
build_lib() {
    local lib=$1
    local dest="$DEPS_DIR/$lib"
    local cap_target=$(capitalize "$TARGET")

    log "Building $lib for $TARGET..."

    case "$lib" in
        coroutines)
            (cd "$dest" && ./gradlew :kotlinx-coroutines-core:publish${cap_target}PublicationToMavenLocal)
            ;;
        io)
            (cd "$dest" && ./gradlew :kotlinx-io-core:publish${cap_target}PublicationToMavenLocal)
            ;;
        datetime)
            (cd "$dest" && ./gradlew :kotlinx-datetime:publish${cap_target}PublicationToMavenLocal)
            ;;
        serialization)
            (cd "$dest" && ./gradlew :kotlinx-serialization-core:publish${cap_target}PublicationToMavenLocal :kotlinx-serialization-json:publish${cap_target}PublicationToMavenLocal)
            ;;
        atomicfu)
            (cd "$dest" && ./gradlew :atomicfu:publish${cap_target}PublicationToMavenLocal)
            ;;
        ktor)
            (cd "$dest" && ./gradlew publish${cap_target}PublicationToMavenLocal)
            ;;
        wgpu4k)
            (cd "$dest" && ./gradlew :wgpu4k-native:publish${cap_target}PublicationToMavenLocal)
            ;;
        *)
            error "Unknown library: $lib"
            return 1
            ;;
    esac
}

# List all libraries
list_libs() {
    for dir in "$SCRIPT_DIR"/*/; do
        if [[ -f "$dir/upstream.txt" ]]; then
            basename "$dir"
        fi
    done
}

# Main
main() {
    local cmd="${1:-}"
    local lib="${2:-}"

    case "$cmd" in
        list)
            list_libs
            ;;
        clone)
            if [[ -z "$lib" ]]; then
                for l in $(list_libs); do
                    clone_and_patch "$l" || warn "Failed to clone $l"
                done
            else
                clone_and_patch "$lib"
            fi
            ;;
        build)
            if [[ -z "$lib" ]]; then
                error "Specify a library: ./build.sh build <lib>"
                exit 1
            fi
            clone_and_patch "$lib"
            build_lib "$lib"
            ;;
        all)
            for l in $(list_libs); do
                clone_and_patch "$l"
                build_lib "$l" || warn "Failed to build $l"
            done
            ;;
        *)
            echo "Usage: ./build.sh <command> [library]"
            echo ""
            echo "Commands:"
            echo "  list          List available libraries"
            echo "  clone [lib]   Clone and patch library (or all)"
            echo "  build <lib>   Build and publish to Maven local"
            echo "  all           Build all libraries"
            echo ""
            echo "Environment:"
            echo "  DEPS_DIR      Where to clone deps (default: ~/.clanker/deps)"
            echo "  TARGET        Build target (default: macosArm64)"
            ;;
    esac
}

main "$@"
