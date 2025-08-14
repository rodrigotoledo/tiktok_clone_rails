# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_create :broadcast_comment

  def broadcast_comment
    broadcast_prepend_to [ post, "comments" ], target: "comments", partial: "comments/comment", locals: { comment: self }
  end
end
