require 'rails_helper'

RSpec.describe PostService do
  subject(:service) { described_class.new(posts_repo) }
  let(:posts_repo)  { PostsRepo.new }
  let!(:admin)      { create(:user, :admin) }
  let!(:post_1)     { create(:post) }
  let!(:post_2)     { create(:post) }
  let!(:post_attributes) do
    { title: 'title', body: 'body' }
  end

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

  describe '#admin_publishes_post' do
    it 'returns Post instance if attributes are valid' do
      expect(service.admin_publishes_post(post_attributes, admin)).
        to be_an_instance_of Post
    end

    it 'returns PostForm instance if attributes are invalid' do
      post_attributes[:title] = ''

      expect(service.admin_publishes_post(post_attributes, admin)).
        to be_an_instance_of PostForm
    end
  end
end
