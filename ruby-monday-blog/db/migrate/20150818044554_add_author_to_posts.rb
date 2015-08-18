class AddAuthorToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :author, index: true
    add_foreign_key :posts, :users, column: 'author_id'
  end
end
