require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'database columns' do
    it { is_expected.to have_db_column :body }
    it { is_expected.to have_db_column :user_id }
    it { is_expected.to have_db_index  :user_id }
    it { is_expected.to have_db_column :commentable_id }
    it { is_expected.to have_db_index  :commentable_id }
    it { is_expected.to have_db_column :commentable_type }
  end

  describe 'associations' do
    it { is_expected.to belong_to :commentable }
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :comments }
  end
end
