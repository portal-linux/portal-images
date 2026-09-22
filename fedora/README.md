# Fedora guest image

Not yet implemented. The Arch spin ships first; Fedora is on the curated
roadmap and will follow.

When built, this image will be produced with mkosi (not archiso, which is
Arch specific). It will ship the same verification contract as every other
curated image: a SHA-256 hash plus a minisign signature, checked by the host
app before boot.
