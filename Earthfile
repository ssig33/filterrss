VERSION 0.6

FROM ruby:3.2.0
WORKDIR /app

build:
  COPY Gemfile Gemfile.lock ./
  RUN bundle -j 20
  COPY . .
  ENV PORT=3000
  ENV RACK_ENV=production
  EXPOSE 3000
  CMD ruby app.rb -p $PORT -o 0.0.0.0

test:
  FROM +build
  RUN bundle exec rake test

release:
  FROM +build

  SAVE IMAGE --push ghcr.io/ssig33/filterrss:main
