class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :role
      t.date :start_date
      t.date :end_date
      t.string :project_url
      t.string :github_url

      t.timestamps
    end
  end
end
