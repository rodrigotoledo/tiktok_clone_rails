# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email_address) }

    it 'validates uniqueness of email_address' do
      create(:user, email_address: 'test@example.com')
      user = build(:user, email_address: 'test@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email_address]).to include('has already been taken')
    end
  end

  describe 'associations' do
    it { should have_many(:sessions) }
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_one(:account) }
  end

  describe 'secure password' do
    it { should have_secure_password }
  end
end
