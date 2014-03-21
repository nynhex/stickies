class CreateStickies < ActiveRecord::Migration
  def change
    create_table :stickies do |t|
      t.string :title
      t.string :body
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
