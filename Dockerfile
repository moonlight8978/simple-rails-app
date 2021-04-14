FROM ruby:3.0.0-alpine3.13 as base

RUN apk --update add \
  build-base \
  tzdata \
  nodejs \
  # for Postgres users
  postgresql-dev \
  # for MySQL users
  mysql-dev \
  # for image processing
  imagemagick \
  file-dev

WORKDIR /app

EXPOSE 3000

# -----
# Development usage
# -----
FROM base as development

RUN apk add \
  nodejs \
  yarn \
  # dev purpose (edit credentials, or debugging)
  vim

RUN gem install rails -v 6.1.3.1
COPY Gemfile* ./
RUN bundle config set without 'staging production' && \
  bundle install

COPY yarn.lock package.json ./
RUN yarn

CMD ["rails", "s", "-b", "0.0.0.0"]

EXPOSE 3035

# ----
# Production usage
# ----

FROM base as production-base

COPY Gemfile* ./
RUN bundle config set without 'test development' && \
  bundle install

FROM production-base as assets-builder

ARG RAILS_MASTER_KEY
ARG RAILS_ENV

RUN apk add \
  nodejs \
  yarn

COPY . .
RUN RAILS_ENV=${RAILS_ENV} RAILS_MASTER_KEY=${RAILS_MASTER_KEY} rails assets:precompile

FROM production-base as production

COPY . .
COPY --from=assets-builder /app/public /app/public

# Temp folders should not be included to production image
RUN mkdir -p tmp/pids tmp/sockets log storage

CMD ["bundle", "exec", "puma"]
