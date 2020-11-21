# OpenStreetMap https://switch2osm.org/serving-tiles/manually-building-a-tile-server-18-04-lts/
FROM ubuntu:18.04
# Installing packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y openjdk-8-jdk maven git
RUN apt install -y osmctools
WORKDIR /opt
# Installing graphhopper
# https://github.com/graphhopper/graphhopper/tree/master/reader-gtfs
RUN git clone https://github.com/graphhopper/graphhopper
WORKDIR /opt/graphhopper
RUN mvn clean package -DskipTests
# Installing sample osm data
RUN wget http://download.geofabrik.de/asia/japan-latest.osm.pbf
# RUN osmconvert japan-latest.osm.pbf -b=133.455201,34.274923,134.298740,35.284564 --complete-ways -o=okayama.pbf
# Installing sample gtfs data
RUN wget "http://www3.unobus.co.jp/opendata/GTFS-JP.zip" -O unobus.gtfs.zip
RUN wget "http://www.shimoden.net/busmada/opendata/GTFS-JP.zip" -O shimodenbus.gtfs.zip
RUN wget "http://loc.bus-vision.jp/gtfs/ryobi/gtfsFeed" -O ryobibus.gtfs.zip
RUN wget "http://loc.bus-vision.jp/gtfs/okaden/gtfsFeed" -O okadenbus.gtfs.zip
RUN wget "http://loc.bus-vision.jp/gtfs/chutetsu/gtfsFeed" -O chutetsubus.gtfs.zip
COPY config-okayama.yml ./
CMD [ "java","-Xmx8g","-jar","web/target/graphhopper-web-3.0-SNAPSHOT.jar","server","config-okayama.yml" ]