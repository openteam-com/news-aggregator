class DeleteExtraColumnFromEntries < ActiveRecord::Migration
  def up
    remove_columns :entries, :status, :news_type
  end

  def down
    add_column :entries, :status, :string
    add_column :entries, :news_type, :string
  end
end
