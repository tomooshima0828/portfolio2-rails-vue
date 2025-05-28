ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION-slim

ARG NODE_MAJOR=18
ARG YARN_VERSION=1.22.19

# 基本的な依存パッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    git \
    libpq-dev \
    pkg-config \
    curl \
    gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Node.js と Yarn のインストール
RUN echo "Attempting to install Node.js major version: ${NODE_MAJOR}" && \
    curl -fsSL https://deb.nodesource.com/setup_${NODE_MAJOR}.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn@${YARN_VERSION}

# アプリケーションディレクトリの設定
WORKDIR /app

# Gemfile と Gemfile.lock をコピーして bundle install を実行
COPY Gemfile Gemfile.lock ./
# pg gem のビルド設定 (pg_config のパスを指定)
# RUN bundle config build.pg --with-pg-config=/usr/bin/pg_config
# 上記はDebian系では不要な場合が多い。問題があればコメントアウトを外す。
# Gemのインストール先をプロジェクト配下の vendor/bundle に設定
RUN bundle config path vendor/bundle
RUN bundle install --jobs $(nproc) --retry 3

# アプリケーションコード全体をコピー
COPY . .

# ポートを公開
EXPOSE 3000

# コンテナ起動時のデフォルトコマンド (docker-compose.yml で上書きされることが多い)
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
