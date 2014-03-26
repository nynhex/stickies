class AddArchiveToSticy < ActiveRecord::Migration
  def change
    add_column :stickies, :archive, :boolean
  end
end
