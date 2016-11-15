require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'database columns' do
    it { is_expected.to have_db_column :title }
    it { is_expected.to have_db_column :body }
    it { is_expected.to have_db_column :user_id }
  end

  describe 'associations' do
    it { is_expected.to belong_to :user }
  end
end
