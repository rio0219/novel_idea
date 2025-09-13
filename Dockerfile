ARG RUBY_VERSION=3.1.4
FROM ruby:$RUBY_VERSION-slim

WORKDIR /rails

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential libpq-dev curl git && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v "~> 2.6" && \
    bundle config set path '/gems' && \
    bundle install --jobs 4 --retry 3

COPY . .

ENV RAILS_ENV=development
EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
