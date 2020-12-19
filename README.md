# Graphhopper Server
The Dockerfile that builds an Graphhopper server.

# Build
```
git clone https://github.com/KentaroAOKI/graphhopper-docker.git
cd openstreetmap-docker
docker build -t graphhopper .
```

# Usage
Download the OpenStreetMap Data and GTFS files before running the container.
```
mkdir osm_data
wget http://download.geofabrik.de/asia/japan-latest.osm.pbf -O ./osm_data/japan-latest.osm.pbf
mkdir gtfs_data
wget http://opendata.sagabus.info/saga-current.zip -O ./gtfs_data/saga-current.zip
wget http://www3.unobus.co.jp/opendata/GTFS-JP.zip -O ./gtfs_data/unobus.gtfs.zip
wget http://www.shimoden.net/busmada/opendata/GTFS-JP.zip -O ./gtfs_data/shimodenbus.gtfs.zip
wget http://loc.bus-vision.jp/gtfs/ryobi/gtfsFeed -O ./gtfs_data/ryobibus.gtfs.zip
wget http://loc.bus-vision.jp/gtfs/okaden/gtfsFeed -O ./gtfs_data/okadenbus.gtfs.zip
wget http://loc.bus-vision.jp/gtfs/chutetsu/gtfsFeed -O ./gtfs_data/chutetsubus.gtfs.zip
```
Mount the GTFS and OpenStreetMap Data directories respectively. Specify the port to bind to and start it.
```
docker run -d -p 80:80 -v /home/user/osm_data:/opt/graphhopper/osm_data -v /home/user/gtfs_data:/opt/graphhopper/gtfs_data graphhopper
```
