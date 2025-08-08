class AddAttachmentToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :attachment, :string
  end
end
