# frozen_string_literal: true

class CreateFollowings < ActiveRecord::Migration[8.0]
  def change
    create_table :followings do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :follower_id
      t.boolean :accepted

      t.timestamps
    end
  end
end
