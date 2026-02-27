# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }

  it 'is valid with valid attributes' do
    expect(comment).to be_valid
  end

  it 'belongs to a user' do
    expect(comment.user).to be_present
  end

  it 'belongs to a post' do
    expect(comment.post).to be_present
  end
end
