require 'progress_bar'

class AddFaviconLinkToSource < ActiveRecord::Migration
  def up
    add_column :sources, :favicon, :string
    src = Source.all
    bar = ProgressBar.new(src.size)
    src.each do |s|
      s.update_attribute :title, s.source
      bar.increment!
    end
  end

  def down
    remove_column :sources, :favicon
  end
end
