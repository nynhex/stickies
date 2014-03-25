class AddPositionToSticky < ActiveRecord::Migration
  def change
    add_column :stickies, :left, :string
    add_column :stickies, :top, :string
  end
end
