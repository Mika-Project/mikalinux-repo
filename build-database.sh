cd x86_64

# Create the database
repo-add -s -n -R mikalinux-repo.db.tar.gz *.pkg.tar.zst


unlink mikalinux-repo.db
unlink mikalinux-repo.files


# Renaming the tar.gz files
mv mikalinux-repo.db.tar.gz mikalinux-repo.db
mv mikalinux-repo.files.tar.gz mikalinux-repo.files
