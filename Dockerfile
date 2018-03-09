#
# Use the barebones version of Ruby 2.5
FROM ruby:2.5-slim

# Optionally set a maintainer name to let people know who made this image.
MAINTAINER C.Köck <c.koeck@planradar.com>

# Install dependencies:
ENV LIBS_VERSION 8.6.1

RUN apt-get update && apt-get install -qq -y build-essential git-core apt-transport-https sqlite3 libsqlite3-dev gnupg --fix-missing --no-install-recommends
RUN apt-get install -qq -y ghostscript imagemagick libmagickcore-dev libmagickwand-dev libgsf-1-dev libmagic1 file time curl --fix-missing --no-install-recommends

# Install libvips
WORKDIR /root
RUN curl -LJO https://github.com/jcupitt/libvips/releases/download/v8.6.1/vips-8.6.1.tar.gz
RUN tar xvf vips-8.6.1.tar.gz
WORKDIR /root/vips-8.6.1
RUN ./configure
RUN make
RUN make install
RUN echo "/usr/local/lib/" >> /etc/ld.so.conf.d/local.conf
RUN apt-get install libvips -qq -y

# RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# #RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main 9.5" | tee /etc/apt/sources.list.d/postgres.list
# #RUN curl -sS https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
# RUn apt-get autoremove
# RUN apt-get update && apt-get install libssl1.1 libpq5 postgresql-client-9.6 libpq-dev nodejs yarn -y

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV INSTALL_PATH /app
RUN mkdir -p $INSTALL_PATH

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.

ADD Gemfile $INSTALL_PATH/
ADD Gemfile.lock $INSTALL_PATH/


WORKDIR $INSTALL_PATH
RUN rm -rf /root/vips-8.6.1
RUN RAILS_ENV=development gem install bundler && bundle install --jobs 20 --retry 5



# --- Add this to your Dockerfile ---

ENV RAILS_ENV development

COPY . ./
RUN RAILS_ENV=development bundle exec spring binstub --all
#RUN chmod a+rwx -R project-dir/system
#RUN chmod a+rwx -R project-dir/system
EXPOSE 3000
ENTRYPOINT /bin/bash