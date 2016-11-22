class RemoveCommentatorNameFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :commentator_name, :string
  end
end
