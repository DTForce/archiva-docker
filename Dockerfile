FROM openjdk:8-alpine

MAINTAINER Jan Mares DT>Force <jan.mares@dtforce.com>

### dependencies?
RUN apk add --no-cache wget

### download archiva binary
WORKDIR /opt/archiva
RUN wget http://apache.spinellicreations.com/archiva/2.2.3/binaries/apache-archiva-2.2.3-bin.tar.gz \
    && tar -xzf apache-archiva-2.2.3-bin.tar.gz

### separate config and data dirs from binary
ENV ARCHIVA_BASE /var/archiva

### expose contextPath as environment variable
ENV ARCHIVA_CONTEXT_PATH /

### get our custom run script
ADD run-archiva /opt/archiva/run-archiva

### start archiva, creating config and data dirs if needed
### allows starting fresh or mounting in ARCHIVA_BASE from host
CMD ["/opt/archiva/run-archiva"]
