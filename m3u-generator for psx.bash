#!/bin/bash

shopt -s nullglob                           #Setting the nullglob so the for loop doesn't return an invalid result when no matches are met


OLDPWD=$PWD                                 #We save the working directory that was used previously, as we're going to change it.
cd /userdata/roms/psx                       #We move to the PSX folder

for DIR in */                               #For each folder in the roms/psx folder
    do cd "$DIR"                            #we enter the folder

    result=(*.{cue,chd,iso})                #count the files matching the extensions and only make a .m3u if there's at least one file matchign the extensions
    if [ ${#result[@]} -ge 1 ];then         

        echo "$(for file in *.{cue,chd,iso} 
            do echo "$(basename "$file")"
            done)" > "${DIR%/}".m3u         #This creates our m3u files using the extensions we accoutned for
    fi
    cd ..                                   #we go back to the parent folder before the next iteration
done

shopt -u nullglob                           #Unsetting the nullglob like it normally is
PWD=$OLDPWD                                 #We go back to the original folder once all is done
