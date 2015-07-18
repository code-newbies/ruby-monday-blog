class RenameTable < ActiveRecord::Migration
  def change
    rename_table :posts_tags, :post_tags
  end
end
