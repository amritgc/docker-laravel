# ------------------------------------------------------------------------------
# Docker provisioning script for the Larazest web server stack
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Start with a Ubuntu 14.04 base image that has been optimised for Docker use
# see https://github.com/phusion/baseimage-docker
# ------------------------------------------------------------------------------

FROM ubuntu:14.04

MAINTAINER Mark Macdonald <mark.t.macdonald@googlemail.com>

# Set correct environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Use Supervisor to run and manage all other services
CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisor.conf"]

# ------------------------------------------------------------------------------
# Provision the server
# ------------------------------------------------------------------------------

RUN mkdir /provision
ADD provision /provision
RUN /provision/provision.sh

# ------------------------------------------------------------------------------
# Prepare image for use
# ------------------------------------------------------------------------------

# Expose ports
EXPOSE 80

# ------------------------------------------------------------------------------
# Clean up
# ------------------------------------------------------------------------------

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*