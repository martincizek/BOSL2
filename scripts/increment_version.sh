#!/bin/sh

VERFILE="version.scad"

vernums=$(grep ^BOSL_VERSION "$VERFILE" | sed 's/^.*[[]\([0-9,]*\)[]].*$/\1/')
major=$(echo "$vernums" | awk -F, '{print $1}')
minor=$(echo "$vernums" | awk -F, '{print $2}')
revision=$(echo "$vernums" | awk -F, '{print $3}')

newrev=$(($revision+1))
echo "Current Version: $major.$minor.$revision"
echo "New Version: $major.$minor.$newrev"

sed -i '' 's/^BOSL_VERSION = .*$/BOSL_VERSION = ['"$major,$minor,$newrev];/g" $VERFILE

exec git add version.scad
exec git commit -m "Bump minor version." 

