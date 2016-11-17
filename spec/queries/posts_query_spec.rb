require 'rails_helper'

RSpec.describe PostsQuery do
  subject(:posts_query) { described_class.new }

  describe '#all_from_the_last' do
    let!(:post_1)   { create(:post) }
    let!(:post_2)   { create(:post) }

    it 'returns all posts in descending order' do
      returned_ids = posts_query.all_from_the_last.pluck(:id)

      expect(returned_ids).to eq([post_2.id, post_1.id])
    end
  end
end
