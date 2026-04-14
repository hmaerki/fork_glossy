#!/usr/bin/env bash
set -euo pipefail

TYPST_VERSION="0.14.2"
TYTANIC_VERSION="0.3.3"
WATCHEXEC_VERSION="2.5.1"
TYPSTYLE_VERSION="0.14.4"

ARCH="$(uname -m)"
case "$ARCH" in
  x86_64) T="x86_64-unknown-linux-musl" ;;
  aarch64) T="aarch64-unknown-linux-musl" ;;
  *)
    echo "Unsupported architecture: $ARCH" >&2
    exit 1
    ;;
esac

curl -fsSL "https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/typst-${T}.tar.xz" \
  | sudo tar -xJ --strip-components=1 -C /usr/local/bin "typst-${T}/typst"

tmp_tt="$(mktemp)"
curl -fsSL "https://github.com/typst-community/tytanic/releases/download/v${TYTANIC_VERSION}/tytanic-${T}.tar.xz" \
  | tar -xJOf - "tytanic-${T}/tt" > "$tmp_tt"
sudo install -m 0755 "$tmp_tt" /usr/local/bin/tt
sudo ln -sf /usr/local/bin/tt /usr/local/bin/tytanic
rm -f "$tmp_tt"

# typstyle: aarch64 releases use gnu, not musl
case "$ARCH" in
  x86_64)  TS="x86_64-unknown-linux-musl" ;;
  aarch64) TS="aarch64-unknown-linux-gnu" ;;
esac

tmp_typstyle="$(mktemp)"
curl -fsSL "https://github.com/typstyle-rs/typstyle/releases/download/v${TYPSTYLE_VERSION}/typstyle-${TS}" \
  -o "$tmp_typstyle"
sudo install -m 0755 "$tmp_typstyle" /usr/local/bin/typstyle
rm -f "$tmp_typstyle"

echo "*** Container build successfully ***"
