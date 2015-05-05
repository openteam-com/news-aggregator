class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :title
      t.string :slug

      t.string :meta_title
      t.text :meta_keywords
      t.text :meta_description
      t.string :header

      t.timestamps
    end
  end
end
