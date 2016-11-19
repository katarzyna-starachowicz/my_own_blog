require 'rails_helper'

RSpec.describe PostService do
  subject(:service) { described_class.new(posts_repo) }
  let(:posts_repo)  { PostsRepo.new }
  let!(:post_1)     { create(:post) }
  let!(:post_2)     { create(:post) }

  describe '#load_entire_post' do
    it 'returns post entity' do
      expect(service.load_entire_post(post_1.id).title).to eq(post_1.title)
    end
  end

  describe '#load_all_posts' do
    let(:all_posts) { service.load_all_posts }

    it 'returns posts in proper order' do
      expect(all_posts.pluck(:id)).to eq([post_2.id, post_1.id])
    end

    it 'returns' do
      expect(all_posts).to be_an_instance_of Post::ActiveRecord_Relation
    end
  end

  describe '#load_empty_post_form' do
    it 'returns an empty post form' do
      expect(service.load_empty_post_form.to_h).to eql PostForm.new.to_h
    end
  end
end
