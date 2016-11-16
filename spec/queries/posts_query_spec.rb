require 'rails_helper'

RSpec.describe PostsQuery do
  subject(:posts_query) { described_class.new }

  describe '#all_from_the_last' do
    let(:post_form) { PostForm.new(title: 'AA', body: 'aa') }
    let(:repo)      { PostsRepo.new }
    let!(:post_1)   { repo.create(post_form) }
    let!(:post_2)   { repo.create(post_form) }

    it 'returns all posts in descending order' do
      returned_ids = posts_query.all_from_the_last.map(&:id)

      expect(returned_ids).to eq([post_2.id, post_1.id])
    end
  end
end
