# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'validations' do
    it { should belong_to(:user) }
    # Add more based on your model
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:posts).through(:user) }
  end

  describe 'methods' do
    let(:account) { create(:account) }  # Use FactoryBot for test data

    it 'has info' do
      expect(account.info).to be_present
    end
  end

  # Add more contexts, e.g., for scopes or edge cases
end
