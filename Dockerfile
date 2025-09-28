FROM ubuntu:24.04
# Installing packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y openjdk-21-jdk maven git
RUN apt install -y osmctools
WORKDIR /opt
# Installing graphhopper
RUN git clone https://github.com/graphhopper/graphhopper -b 6.2 --depth 1
WORKDIR /opt/graphhopper
RUN mvn clean package -DskipTests
RUN mkdir osm_data
RUN mkdir gtfs_data
RUN mkdir config
COPY config ./config
COPY scripts ./scripts
RUN chmod 700 scripts/*
# Installing sample osm data
# WORKDIR /opt/graphhopper/osm_data
# RUN wget http://download.geofabrik.de/asia/japan-latest.osm.pbf
# RUN osmconvert japan-latest.osm.pbf -b=133.455201,34.274923,134.298740,35.284564 --complete-ways -o=okayama.pbf
# Installing sample gtfs data
# WORKDIR /opt/graphhopper/gtfs_data
# RUN wget "http://www3.unobus.co.jp/opendata/GTFS-JP.zip" -O unobus.gtfs.zip
# RUN wget "http://www.shimoden.net/busmada/opendata/GTFS-JP.zip" -O shimodenbus.gtfs.zip
# RUN wget "http://loc.bus-vision.jp/gtfs/ryobi/gtfsFeed" -O ryobibus.gtfs.zip
# RUN wget "http://loc.bus-vision.jp/gtfs/okaden/gtfsFeed" -O okadenbus.gtfs.zip
# RUN wget "http://loc.bus-vision.jp/gtfs/chutetsu/gtfsFeed" -O chutetsubus.gtfs.zip
EXPOSE 8989
EXPOSE 8990
CMD [ "scripts/run.sh" ]