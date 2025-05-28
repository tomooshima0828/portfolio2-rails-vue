# frozen_string_literal: true

puts 'Destroying existing data...'
ProjectTechnology.destroy_all
Project.destroy_all
Technology.destroy_all

puts 'Creating Technologies...'

# Define technologies based on skillsheet
tech_names = [
  'Ruby', 'Ruby on Rails', 'JavaScript', 'TypeScript', 'jQuery', 'Vue.js', 'React',
  'HTML', 'CSS', 'PostgreSQL', 'MySQL', 'Docker', 'AWS', 'Heroku', 'RSpec'
]

technologies = tech_names.each_with_object({}) do |name, hash|
  hash[name.downcase.gsub(/[^a-z0-9]+/, '_').to_sym] = Technology.find_or_create_by!(name: name)
end

puts "Ensured #{Technology.count} technologies exist."

puts 'Creating Projects based on スキルシート_大島智彦.csv...'

# Project 1: 駐車場管理システムの開発
project1 = Project.create!(
  title: '駐車場管理システムの開発',
  description: '業界大手の駐車場管理システム企業の管理システムの自社開発案件で、ゲートレス駐車場(ゲートが無くカメラで車両を特定して駐車料金を請求・決済する駐車場)の利用者の駐車料金の支払い画面や、各駐車場施設ごとの管理システムの管理者画面について、UIの詳細設計、実装、手動テスト、バグ改修を行いました。',
  role: 'PG',
  start_date: Date.new(2024, 4, 1),
  end_date: Date.new(2025, 4, 30),
  project_url: nil,
  github_url: nil
)
project1.technologies << [
  technologies[:html], technologies[:css], technologies[:ruby_on_rails], technologies[:vue_js],
  technologies[:ruby], technologies[:javascript], technologies[:typescript], technologies[:mysql],
  technologies[:docker], technologies[:aws]
]

# Project 2: 寿司チェーン店のモバイルアプリ用のAPIの管理画面の開発
project2 = Project.create!(
  title: '寿司チェーン店のモバイルアプリ用のAPIの管理画面の開発',
  description: '大手寿司チェーン店のモバイルアプリ用のAPI機能の開発案件で、管理画面の機能追加と新規画面の開発を行いました。ドキュメント化が徹底している現場で、画面ワイヤーフレームの作成、作成箇所のER図の作成、API機能定義書、結合テスト仕様書、単体テスト項目書を実装と合わせて作成し、RSpecによるテストコードの実装を行いました。',
  role: 'PG',
  start_date: Date.new(2023, 12, 1),
  end_date: Date.new(2024, 2, 29),
  project_url: nil,
  github_url: nil
)
project2.technologies << [
  technologies[:html], technologies[:css], technologies[:ruby_on_rails], technologies[:ruby],
  technologies[:mysql], technologies[:docker], technologies[:rspec] # Added RSpec based on description
]

# Project 3: コンサルティング企業の課題解決プラットフォーム、プロジェクト管理アプリ
project3 = Project.create!(
  title: 'コンサルティング企業の課題解決プラットフォーム、プロジェクト管理アプリ',
  description: 'コンサルティング企業の課題解決のためのプロジェクト管理アプリケーションのV1リリース直後のバグ改修を主として行いました。また、関連するアイデア発想アプリケーションの新規開発も担当しました。',
  role: 'PG',
  start_date: Date.new(2022, 5, 1),
  end_date: Date.new(2023, 10, 31),
  project_url: nil,
  github_url: nil
)
project3.technologies << [
  technologies[:html], technologies[:css], technologies[:ruby_on_rails], technologies[:ruby],
  technologies[:javascript], technologies[:jquery], technologies[:postgresql], technologies[:mysql],
  technologies[:docker], technologies[:aws], technologies[:rspec]
]

# Project 4: 建設業の業務効率化システムの新規開発
project4 = Project.create!(
  title: '建設業の業務効率化システムの新規開発',
  description: '建設業界向けのクラウド型サービスで、書類の作成・提出・管理を効率化するシステムの新規開発を行いました。開発途中からの参画でしたので、急遽キャッチアップしながら実装を行いました。',
  role: 'PG',
  start_date: Date.new(2021, 11, 1),
  end_date: Date.new(2022, 4, 30),
  project_url: nil,
  github_url: nil
)
project4.technologies << [
  technologies[:ruby], technologies[:javascript], technologies[:jquery], technologies[:html],
  technologies[:css], technologies[:ruby_on_rails], technologies[:postgresql], technologies[:docker],
  technologies[:aws], technologies[:rspec]
]

# Project 5: フットケア/マッサージ店の予約、物販サイトの新規開発
project5 = Project.create!(
  title: 'フットケア/マッサージ店の予約、物販サイトの新規開発',
  description: '小規模のフットケア/マッサージのチェーン店の予約と物販のサイトの新規開発に参画させていただく機会をいただき、プロダクトオーナー様とのミーティングにも参加させていただき、担当箇所の画面遷移図の作成と実装を行いました。',
  role: 'PG',
  start_date: Date.new(2021, 3, 1),
  end_date: Date.new(2021, 10, 31),
  project_url: nil,
  github_url: nil
)
project5.technologies << [
  technologies[:ruby], technologies[:ruby_on_rails], technologies[:jquery], technologies[:javascript],
  technologies[:html], technologies[:css], technologies[:docker], technologies[:heroku]
]

puts "Created #{Project.count} projects."

puts 'Finished seeding!'
