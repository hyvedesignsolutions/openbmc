#
# These file add version 

python() {
        d.setVar('VERSION', "v0.02-00-hs9216")
        d.setVar('VERSION_ID', "v0.02-00-hs9216")
}


# Ensure the git commands run every time bitbake is invoked.
BB_DONT_CACHE = "1"

# Make os-release available to other recipes.
SYSROOT_DIRS_append = " ${sysconfdir}"
