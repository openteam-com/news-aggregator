class CreateRssbases < ActiveRecord::Migration
  def change
    create_table :rssbases do |t|
      t.text :title
      t.string :url
      t.string :description
      t.text :content
      t.string :theme
      t.integer :status, :default => 0
      t.string :image_url
      t.integer :main, :default =>0
      t.datetime :published
      t.string :category
      t.timestamps
    end
  end
end
