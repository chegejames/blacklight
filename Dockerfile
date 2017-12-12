FROM ruby:2.4.2

RUN apt-get update --fix-missing

# application dependencies
RUN apt-get install -y libmysqlclient-dev libpq-dev libcurl4-openssl-dev nodejs cron

RUN apt-get install -y software-properties-common

RUN echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN apt-get update

RUN apt-get install -y -t  jessie-backports openjdk-8-jre-headless ca-certificates-java

RUN java -version

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc

WORKDIR /web/
ADD Gemfile /web/
ADD Gemfile.lock /web/
#RUN bundle install --deployment --without development --jobs=2

RUN bundle install

ADD . /web/

RUN bundle exec rake db:migrate


# if you need to run post-deploy rake tasks that bake or precompute something
# on the local filesystem, do it here
#CMD bundle exec rake do_the_post_deploy_things

EXPOSE 8080

CMD bundle exec unicorn -c ./config/unicorn.conf.rb



