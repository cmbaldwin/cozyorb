class AddDisplayToLike < ActiveRecord::Migration[6.0]
  def change
  	add_column :likes, :display, :boolean
  end
end
