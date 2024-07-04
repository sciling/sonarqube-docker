FROM sonarqube:10.4.1-community

# Copy the script that installs extensions
COPY configure-sonarqube.sh /tmp
# Install the extensions
RUN /tmp/configure-sonarqube.sh /opt/sonarqube/extensions/plugins/
