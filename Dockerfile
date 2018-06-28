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
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
###################################################################################################

FROM ubuntu:18.04

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y ca-certificates wget nano git libwww-perl libjson-perl libterm-readkey-perl zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget -q -O "/usr/local/bin/gitlab-runner" "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64" && \
    chmod +x "/usr/local/bin/gitlab-runner" && \
    useradd --comment "GitLab Runner" --create-home "gitlab-runner" --shell "/bin/bash" && \
    echo "GitLab Runner successfully installed"

VOLUME ["/etc/gitlab-runner", "/home/gitlab-runner"]

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["run", "--working-directory=/home/gitlab-runner", "--user=gitlab-runner"]