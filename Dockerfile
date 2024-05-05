FROM ruby:3.2.1

RUN apt-get update -qq && apt-get install -y postgresql-client

WORKDIR /app

# Adding gems
COPY Gemfile* /app/
RUN gem install bundler:2.5.10
RUN bundle install

COPY . .

CMD ["bundle", "exec", "puma"]
