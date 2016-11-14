require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
  end

  describe 'database columns' do
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :admin }
  end

  describe 'admin column' do
    let(:user) { create :user }

    it 'is default false' do
      expect(user.admin?).to be false
    end
  end

  describe 'associations' do
    it { is_expected.to have_many :posts }
  end
end
