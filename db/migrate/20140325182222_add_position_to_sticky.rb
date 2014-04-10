class AddPositionToSticky < ActiveRecord::Migration
  def change
    add_column :stickies, :left_ratio, :float
    add_column :stickies, :top, :string
  end
end
