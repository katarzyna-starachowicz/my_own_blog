require 'rails_helper'

RSpec.describe PostService do
  subject(:service) { described_class.new(post_repo) }
  let(:post_repo)   { PostRepo.new }
  let(:post_1)      { create(:post) }
  let(:post_2)      { create(:post) }

  describe '#load_entire_post' do
    it 'returns post entity if it exists' do
      expect(service.load_entire_post(post_1.id).title).to eq(post_1.title)
    end

    it 'returns nil if it does not exist' do
      expect(service.load_entire_post(0)).to be nil
    end
  end

  describe '#load_all_posts' do
    let(:all_posts) { service.load_all_posts }

    it 'returns posts in proper order' do
      expect(all_posts).to match_array [post_2, post_1]
    end

    it 'returns' do
      expect(all_posts).to be_an_instance_of Post::ActiveRecord_Relation
    end
  end
end
