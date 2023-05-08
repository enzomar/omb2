FROM nginx:1.23.4
# Setting up time zone
ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Replication configuration


# copy all the configurtions
# COPY conf/nginx.conf /etc/nginx/nginx.conf