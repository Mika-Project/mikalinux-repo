# pacmanrepo

Pacman repository for the Mika Linux OS

add this to pacman.conf to use repo:

```
[mikalinux-repo]
SigLevel = Optional TrustAll
Server = https://github.com/Mika-Project/$repo/raw/main/$arch
```

---

To build the database run the build-database.sh file.

```
sh build-database.sh
```
