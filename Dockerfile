FROM wmarinho/ubuntu:oracle-jdk-7

MAINTAINER Caio Moreno de Souza caiomsouza@gmail.com

# Init ENV
ENV PDI_TAG 5.3.0.0-213

ENV PENTAHO_HOME /opt/pentaho

# Apply JAVA_HOME
RUN . /etc/environment
ENV PENTAHO_JAVA_HOME /usr/lib/jvm/java-7-oracle

RUN apt-get update \
    && apt-get install wget unzip git -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Download Pentaho Data Integration (PDI) (pdi-ce-5.3.0.0-213.zip)
#RUN /usr/bin/wget -nv  http://ci.pentaho.com/view/Data%20Integration/job/kettle-5.1/lastSuccessfulBuild/artifact/assembly/dist/pdi-ce-${PDI_TAG}.zip -O /tmp/pdi-ce-${PDI_TAG}.zip 
RUN /usr/bin/wget -nv http://downloads.sourceforge.net/project/pentaho/Data%20Integration/5.3/pdi-ce-${PDI_TAG}.zip -O /tmp/pdi-ce-${PDI_TAG}.zip

RUN  /usr/bin/unzip -q /tmp/pdi-ce-${PDI_TAG}.zip -d  $PENTAHO_HOME &&\
     rm /tmp/pdi-ce-${PDI_TAG}.zip

COPY run.sh /opt/pentaho/data-integration/
# COPY slave_dyn.xml /opt/pentaho/data-integration/

WORKDIR /opt/pentaho/data-integration

# EXPOSE 8181

#CMD ["./run.sh"]
