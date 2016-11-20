require 'rails_helper'

RSpec.describe PostRepo do
  subject(:repo) { described_class.new }

  let(:admin_1) { create(:user, :admin) }
  let(:admin_2) { create(:user, :admin) }
  let(:post_1)  { create(:post, title: 'title_1', user_id: admin_1.id) }
  let(:post_2)  { create(:post, user_id: admin_2.id) }

  describe '#find' do
    it 'finds a post by id' do
      expect(repo.find(post_2.id)).to eq(post_2)
    end
  end

  describe '#find_admins_post' do
    it "returns a post if it belongs to admin" do
      expect(repo.find_admins_post(admin_2.id, post_2.id)).to eq(post_2)
    end

    it 'returns nil if admin post does not belong to admin' do
      expect(repo.find_admins_post(admin_2.id, post_1.id)).to be nil
    end
  end

  describe '#create' do
    let(:form) do
      PostForm.new(
        title:   'title',
        body:    'body',
        user_id: admin_1.id
      )
    end

    it 'creates a new post' do
      expect { repo.create(form) }.to change { Post.count }.by(1)
    end
  end

  describe '#update' do
    let(:form) do
      PostForm.new(
        id:      post_1.id,
        title:   'title_2',
        body:    post_1.body,
        user_id: admin_1.id
      )
    end

    it 'updates a post' do
      expect { repo.update(form) }.
        to change { post_1.reload.title }.from('title_1').to('title_2')
    end
  end

  describe '#destroy' do
    let(:post_1_id) { post_1.id }
    before { repo.destroy(post_1_id) }

    it 'destroys a post' do
      expect { repo.find(post_1_id) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
