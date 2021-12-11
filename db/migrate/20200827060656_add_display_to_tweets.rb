class AddDisplayToTweets < ActiveRecord::Migration[6.0]
  def change
  	add_column :tweets, :display, :boolean
  end
end
