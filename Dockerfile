###################################################################################################
# Copyright (c) 2018, Nils Knieling. All rights reserved.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
###################################################################################################
FROM ubuntu:18.04

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y ca-certificates wget curl nano git libwww-perl libjson-perl libterm-readkey-perl zip gnupg2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install CF CLI
RUN wget -O cf-cli.key https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key && \
    apt-key add cf-cli.key && \
    echo "deb https://packages.cloudfoundry.org/debian stable main" >> /etc/apt/sources.list.d/cloudfoundry-cli.list && \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y cf-cli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install GitLab Runner
RUN wget -q -O "/usr/local/bin/gitlab-runner" "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64" && \
    chmod +x "/usr/local/bin/gitlab-runner" && \
    useradd --comment "GitLab Runner" --create-home "gitlab-runner" --shell "/bin/bash" && \
    echo "GitLab Runner successfully installed"

# Preserve runner's data
VOLUME ["/etc/gitlab-runner", "/home/gitlab-runner"]

# init sets up the environment and launches gitlab-runner
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["run", "--working-directory=/home/gitlab-runner", "--user=gitlab-runner"]
