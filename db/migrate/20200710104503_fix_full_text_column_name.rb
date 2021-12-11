class FixFullTextColumnName < ActiveRecord::Migration[6.0]
  def self.up
    rename_column :likes, :fullText, :full_text
  end

  def self.down
    rename_column :likes, :full_text, :fullText
  end
end
