# ステージ1: ビルド環境
FROM node:18-alpine AS build-stage

WORKDIR /usr/src/app

# package.json と package-lock.json (または yarn.lock) をコピー
COPY package*.json yarn.lock* ./

# 依存関係をインストール
RUN yarn install --frozen-lockfile

# ソースコードをコピー
COPY . .

# Vueアプリをビルド
RUN yarn build

# ステージ2: 本番環境 (Nginxで配信)
FROM nginx:stable-alpine AS production-stage

# ビルドされた静的ファイルをNginxのドキュメントルートにコピー
COPY --from=build-stage /usr/src/app/dist /usr/share/nginx/html

# Nginxの設定ファイルをコピー (オプション)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
