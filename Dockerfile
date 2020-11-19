FROM centos:8

RUN yum -y update && yum -y install  jq && mkdir -p /app/csv && mkdir -p /app/data

WORKDIR /app
ADD covid_basher.sh .
CMD ["./covid_basher.sh"]
