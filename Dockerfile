FROM openjdk:8-alpine

MAINTAINER Jan Mares DT>Force <jan.mares@dtforce.com>

### dependencies?
RUN apk add --no-cache wget bash ca-certificates libc6-compat

### download archiva binary
WORKDIR /opt/archiva
RUN wget http://apache.spinellicreations.com/archiva/2.2.3/binaries/apache-archiva-2.2.3-bin.tar.gz && \
    tar -xzf apache-archiva-2.2.3-bin.tar.gz && \
    mv /opt/archiva/apache-archiva-2.2.3 /opt/archiva/apache-archiva-src

### separate config and data dirs from binary
ENV ARCHIVA_BASE /var/archiva

### expose contextPath as environment variable
ENV ARCHIVA_CONTEXT_PATH /

### get our custom run script
ADD run-archiva /opt/archiva/run-archiva

RUN chmod a+x /opt/archiva/run-archiva && \
    mkdir -p /var/archiva/logs && \
    mkdir -p /var/archiva/data && \
    mkdir -p /var/archiva/temp && \
    cp -r /opt/archiva/apache-archiva-src/conf /var/archiva

### start archiva, creating config and data dirs if needed
### allows starting fresh or mounting in ARCHIVA_BASE from host
CMD ["/opt/archiva/run-archiva"]
