#######################################################
# Project: Benjamin-Chung Lab Example Repo

# Description: Code to set up and update renv
#######################################################

# Run once, to intitialize renv files for the project
renv::init()

# Run each time you want to update the renv lockfile
# Ex: when you update a package
renv::snapshot()