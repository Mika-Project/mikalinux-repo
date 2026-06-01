# mikalinux-repo

The custom **pacman repository** for [Mika Linux](https://github.com/Mika-Project/base-iso),
served straight from this GitHub repo (over `raw`). It holds the packages Mika needs
that aren't in the official Arch repos — most importantly the **Calamares** installer
and the **soname shims** that keep it working on rolling Arch.

---

## Use the repo

Add this to `/etc/pacman.conf`, then refresh:

```ini
[mikalinux-repo]
SigLevel = Optional TrustAll
Server = https://github.com/Mika-Project/$repo/raw/main/$arch
```

```bash
sudo pacman -Sy
```

Mika's own [`base-iso`](https://github.com/Mika-Project/base-iso) build already has
this configured in its `pacman.conf`.

---

## What's inside

`x86_64/` holds the prebuilt packages plus the repo database. The important ones:

| Package | Why it's here |
|---------|--------------|
| `calamares` | The graphical installer (AUR-only upstream; shipped prebuilt here). |
| `yaml-cpp08-shim`, `python310-shim`, `boost-python311-shim` | **Soname shims.** Calamares is a *pinned* binary; when Arch bumps a library soname (yaml-cpp `0.8→0.9`, python `3.10→3.11`, …) the old `.so` vanishes and Calamares won't start. These ship the old soname so it keeps loading. |
| `ckbcomp` | Keyboard-layout preview for the Calamares keyboard page. |
| `yay`, `cava`, `nwg-look-bin`, `swww`, `swaylock-effects`, `wlsunset`, … | Extra AUR / desktop packages Mika uses. |

> [!NOTE]
> The shims are a stop-gap. The proper fix is to **rebuild Calamares against current
> libraries** so it needs none — that's what
> [os-installer](https://github.com/Mika-Project/os-installer) is for.

---

## Add or update a package

1. Drop the built `*.pkg.tar.zst` into `x86_64/`.
2. Regenerate the database:

```bash
sh build-database.sh
```

That runs `repo-add` and rewrites `mikalinux-repo.db` / `mikalinux-repo.files`.

> [!IMPORTANT]
> The database is committed as **plain files**, not the symlinks `repo-add` makes by
> default — GitHub `raw` can't follow symlinks. `build-database.sh` already renames
> `*.db.tar.gz` → `*.db` for you. Commit the new package **and** the regenerated
> `*.db` / `*.files` together, or clients will fail to find it.
