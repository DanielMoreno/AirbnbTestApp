FROM ruby:2.3.7

RUN apt-get update -yqq

RUN apt-get install -yqq --no-install-recommends \
    git \
    nodejs \
    gcc \
    openssl \
    libreadline-dev \
    sqlite3 \
    libsqlite3-dev

RUN mkdir -p /var/www/html/AirbnbTestApp/

WORKDIR /var/www/html/AirbnbTestApp/

RUN git clone https://github.com/DanielMoreno/AirbnbTestApp.git /var/www/html/AirbnbTestApp

RUN rm Gemfile.lock

RUN bundle install

RUN rake db:drop db:create db:migrate db:setup

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]