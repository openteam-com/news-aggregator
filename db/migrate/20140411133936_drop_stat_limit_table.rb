class DropStatLimitTable < ActiveRecord::Migration
  def up
    drop_table :stat_limits
  end

  def down
    create_table :stat_limits do |t|
      t.integer :limit, default: 0
    end
  end
end
