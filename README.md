portfolio-rails-vue/
├── .gitignore             # プロジェクト全体の .gitignore
├── README.md              # プロジェクト全体の README
├── backend/               # Rails アプリケーション (API)
│   ├── .dockerignore
│   ├── Dockerfile         # Railsアプリケーション用
│   ├── Gemfile
│   ├── Gemfile.lock
│   ├── Rakefile
│   ├── config.ru
│   ├── app/
│   │   ├── controllers/
│   │   │   └── api/
│   │   │       └── v1/
│   │   ├── models/
│   │   └── ... (その他Railsのディレクトリ)
│   ├── config/
│   │   ├── database.yml
│   │   ├── routes.rb      # APIエンドポイントのルーティング
│   │   └── ... (その他Railsの設定ファイル)
│   ├── db/
│   ├── lib/
│   ├── log/
│   ├── public/
│   ├── spec/              # RSpecテストファイル
│   ├── storage/
│   ├── tmp/
│   └── vendor/
├── frontend/              # Vue.js アプリケーション
│   ├── .eslintignore
│   ├── .eslintrc.js
│   ├── Dockerfile         # Vue.jsアプリケーション用 (例: Nginxで静的ファイル配信)
│   ├── README.md
│   ├── babel.config.js
│   ├── package.json
│   ├── package-lock.json
│   ├── postcss.config.js
│   ├── public/
│   │   ├── favicon.ico
│   │   └── index.html
│   └── src/
│       ├── App.vue
│       ├── assets/
│       ├── components/
│       ├── main.js
│       ├── router/
│       ├── store/
│       └── views/
└── docker-compose.yml     # Docker Compose設定ファイル