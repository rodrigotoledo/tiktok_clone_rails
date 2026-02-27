# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Following, type: :model do
  describe 'creation' do
    it 'is valid with a user' do
      following = build(:following)
      expect(following).to be_valid
    end

    it 'is invalid without a user' do
      following = build(:following, user: nil)
      expect(following).not_to be_valid
      expect(following.errors[:user]).to include("must exist")
    end
  end
end
