class CreateStatLimits < ActiveRecord::Migration
  def change
    create_table :stat_limits do |t|
      t.integer :limit, default: 0
    end
  end
end
