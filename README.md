# portal-images

Builds and signs the curated Linux guest images for the Portal project.

Portal runs ARM64 Linux distros on Apple Silicon Macs using Apple's
Virtualization.framework. This repo is the image side of that project: it
produces the curated guest images the host app can download, verify, and boot.

## Curated distros

| Distro    | Build tool | Status                      |
| --------- | ---------- | --------------------------- |
| arch-spin | archiso    | scaffolded (ships first)    |
| Fedora    | mkosi      | planned, not implemented    |
| Ubuntu    | mkosi      | planned, not implemented    |
| Debian    | mkosi      | planned, not implemented    |
| NixOS     | nix flake  | planned, not implemented    |

The Arch spin is the project's own default image. It is built with archiso and
ships a `portal` user, sshd enabled, and cloud-init for unattended install. The
other distros are on the roadmap; each has a placeholder README describing how
it will be built.

## Verification model

Every curated image ships two extra files alongside the image itself:

- a SHA-256 hash of the image
- a minisign signature

The host app checks both before boot. The hash catches corrupted or truncated
downloads; the minisign signature proves the image came from this project and
was not tampered with in transit or on a mirror. An image that fails either
check is not booted.

`manifest.json` is the index the host app reads. Each entry names the image,
its version, arch, expected SHA-256, signature, minimum compatible app version,
and download URL. The example entry in the committed manifest uses obvious
placeholder hash and signature values (all-zero hash, a clearly-fake
signature string) so nobody mistakes scaffold data for real signed data.

## Builds

Images are built in GitHub Actions on a weekly cron (and on manual
`workflow_dispatch`) and published to GitHub Releases. See
`.github/workflows/build-images.yml`. The arch-spin job builds the ISO with
archiso, hashes it, signs it with minisign using repo secrets, and uploads the
image plus its `.sha256` and `.minisig` to a release.

## Licensing

The scripts and tooling in this repo are licensed under Apache 2.0. See
`LICENSE`.

The guest images this repo produces are NOT covered by that license. Each
image is a build of an upstream distribution and inherits that distribution's
own license and the licenses of the packages it contains (Arch, Fedora,
Ubuntu, Debian, NixOS, and so on). Apache 2.0 here applies only to Portal's
own build scripts, profiles, and CI, not to the distributed images.
