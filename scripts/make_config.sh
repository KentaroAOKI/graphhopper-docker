#/bin/bash
for file in `ls ./osm_data/*.pbf`
do
if test "$osmlist" = ""
then
osmlist=$file
else
osmlist=$osmlist,$file
fi
done

for file in `ls ./gtfs_data/*.zip`
do
if test "$gtfslist" = ""
then
gtfslist=$file
else
gtfslist=$gtfslist,$file
fi
done

sed -e 's/DATAREADER_FILES/'${osmlist//\//\\\/}'/' -e 's/GTFS_FILES/'${gtfslist//\//\\\/}'/' config/config-template.yml > config/config.yml