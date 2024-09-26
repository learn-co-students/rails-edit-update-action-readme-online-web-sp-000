class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, default: nil
      t.text :description, default: nil

      t.timestamps null: false
    end
  end
end
