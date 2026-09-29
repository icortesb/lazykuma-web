---
sidebar_position: 1
---

# Installation

lazykuma is one static binary with no runtime dependencies. Builds for Linux, macOS and
Windows, on amd64 and arm64, are attached to every
[release](https://github.com/icortesb/lazykuma/releases).

The archives are named `lazykuma_<system>_<arch>`: a `.tar.gz` for Linux and macOS, a `.zip`
for Windows. Each holds the binary, `LICENSE` and `README.md`. The commands below always fetch
the latest release (`releases/latest/download/…`); for an older one, pick it from the releases
page. Releases before v0.7.1 carry the version in the name: `lazykuma_0.7.0_linux_amd64.tar.gz`.

## Linux

```sh
curl -fsSL https://github.com/icortesb/lazykuma/releases/latest/download/lazykuma_linux_amd64.tar.gz | tar -xzf - lazykuma
mkdir -p ~/.local/bin && mv lazykuma ~/.local/bin/
```

On an arm64 machine (a Raspberry Pi 4 or 5 with a 64-bit system, say) take `linux_arm64`
instead. `~/.local/bin` must be on your `PATH`; most distributions put it there for you.

## macOS

```sh
curl -fsSL https://github.com/icortesb/lazykuma/releases/latest/download/lazykuma_darwin_arm64.tar.gz | tar -xzf - lazykuma
sudo mkdir -p /usr/local/bin && sudo mv lazykuma /usr/local/bin/
```

`darwin_arm64` is for Apple silicon, `darwin_amd64` for Intel Macs. The binary is not signed:
downloaded with a browser instead of `curl`, macOS refuses to open it until you clear the
quarantine flag with `xattr -d com.apple.quarantine lazykuma`.

## Windows

In PowerShell:

```powershell
Invoke-WebRequest https://github.com/icortesb/lazykuma/releases/latest/download/lazykuma_windows_amd64.zip -OutFile lazykuma.zip
Expand-Archive lazykuma.zip -DestinationPath lazykuma
.\lazykuma\lazykuma.exe
```

Move `lazykuma.exe` to a folder on your `PATH` to run it from anywhere. `windows_arm64` is
for ARM machines.

## With Go

Needs Go 1.27 or newer. An older toolchain (1.21 or later) fetches 1.27 by itself, unless
`GOTOOLCHAIN=local` is set.

```sh
go install github.com/icortesb/lazykuma/cmd/lazykuma@latest
```

This leaves the binary in `$(go env GOPATH)/bin`, which is on the `PATH` only if you have put
it there — `lazykuma: command not found` right after a successful install means you have not:

```sh
export PATH="$(go env GOPATH)/bin:$PATH"
```

A binary built this way reports its version as `dev`.

## From source

```sh
git clone https://github.com/icortesb/lazykuma
cd lazykuma
make build
```

## Verify

Every release carries a `checksums.txt` with the SHA-256 of each archive. To check an archive
before unpacking it, download it and the checksums into the same folder:

```sh
curl -fsSLO https://github.com/icortesb/lazykuma/releases/latest/download/lazykuma_linux_amd64.tar.gz
curl -fsSLO https://github.com/icortesb/lazykuma/releases/latest/download/checksums.txt
sha256sum --ignore-missing -c checksums.txt
```

On macOS, `shasum -a 256 --ignore-missing -c checksums.txt` does the same. Then check the
binary runs:

```sh
lazykuma --version
```

## Upgrading

Replace the binary with the new one. If [background alerts](/without-the-tui/background-alerts)
are on, after upgrading run `lazykuma autostart on` so the background watch restarts on the new
binary (and the login entry points at its path, if it moved).
