#! /bin/bash

# https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -exo pipefail
set -eo pipefail

CURRENT_LOCATION="$(pwd)"
CURRENT_SCRIPT="$( realpath "${BASH_SOURCE[0]:-${(%):-%x}}" )"
SCRIPT_LOCATION="$( cd "$( dirname "$CURRENT_SCRIPT" )/.." &> /dev/null && pwd )"

usage()
{
    echo "usage: $0 [sonarqube extensions plugin directory"]
    echo "* -a:   account to connect to codeartifact"
    echo "* -d:   domain which will be used in codeartifact"
    echo ""
    echo "example:      $1 /docker/volumes/sonarqube/extensions/plugins"
    exit 1
}


PLUGIN_DIR="$1"
if ! test -d "$PLUGIN_DIR"; then
  echo "Cannot find '${PLUGIN_DIR}' or it is not a directory or you don't have permissions"
  usage
fi


cd "$PLUGIN_DIR"

PLUGIN_LIST=(
  https://github.com/sbaudoin/sonar-shellcheck/releases/download/v2.5.0/sonar-shellcheck-plugin-2.5.0.jar
  https://github.com/QualInsight/qualinsight-plugins-sonarqube-smell/releases/download/qualinsight-plugins-sonarqube-smell-4.0.0/qualinsight-sonarqube-smell-plugin-4.0.0.jar
  https://oss.sonatype.org/service/local/repositories/releases/content/com/hack23/sonar/sonar-cloudformation-plugin/3.0.11/sonar-cloudformation-plugin-3.0.11.jar
  https://github.com/sbaudoin/sonar-ansible/releases/download/v2.5.1/sonar-ansible-plugin-2.5.1.jar
  https://github.com/mc1arke/sonarqube-community-branch-plugin/releases/download/1.19.0/sonarqube-community-branch-plugin-1.19.0.jar
  https://github.com/dependency-check/dependency-check-sonar-plugin/releases/download/4.0.1/sonar-dependency-check-plugin-4.0.1.jar
  https://github.com/porscheinformatik/sonarqube-licensecheck/releases/download/v6.0.1/sonarqube-licensecheck-plugin-6.0.1.jar
  https://github.com/cnescatlab/sonar-cnes-report/releases/download/4.3.0/sonar-cnes-report-4.3.0.jar
  https://github.com/cnescatlab/sonar-hadolint-plugin/releases/download/1.1.0/sonar-hadolint-plugin-1.1.0.jar
  https://github.com/sbaudoin/sonar-yaml/releases/download/v1.9.1/sonar-yaml-plugin-1.9.1.jar
)

for plugin in "${PLUGIN_LIST[@]}"; do
  echo "Downloading ${plugin#.*} ..."
  wget -c -q "$plugin"
done

echo

cat <<EOF
Read the following docs to tweak your linux server.

https://docs.sonarsource.com/sonarqube/10.4/requirements/prerequisites-and-overview/#linux

Also make sure that you have at least 10% disk free or sonar's elastic search instance will not start

The default admin user and password is admin:admin
Please, change it as soon as possible.
EOF
