require 'rails_helper'

RSpec.describe Admin::PostService do
  subject(:service) { described_class.new(post_repo) }
  let!(:post_repo)  { PostRepo.new }
  let!(:admin)      { create(:user, :admin) }
  let!(:post_1)     { create(:post) }
  let!(:post_2)     { create(:post, user_id: admin.id) }
  let(:title)       { 'title' }
  let!(:post_attributes) do
    { title: title, body: 'body' }
  end

  describe '#admin_writes_new_post' do
    it 'returns an empty post form' do
      expect(service.admin_writes_new_post.to_h).to eql PostForm.new.to_h
    end
  end

  describe '#admin_publishes_new_post' do
    context 'when attributes are valid' do
      it 'returns Post instance' do
        expect(service.admin_publishes_new_post(post_attributes, admin)).
          to be_an_instance_of Post
      end
    end

    context 'when attributes are invalid' do
      let(:title) { nil }

      it 'returns PostForm instance if attributes are invalid' do
        expect(service.admin_publishes_new_post(post_attributes, admin)).
          to be_an_instance_of PostForm
      end
    end
  end

  describe '#admin_edits_post' do
    let(:post_2_form) do
      PostForm.new(
        id:      post_2.id,
        user_id: post_2.user_id,
        title:   post_2.title,
        body:    post_2.body
      )
    end

    context 'when post belongs to admin' do
      it 'returns PostForm' do
        expect(service.admin_edits_post(post_2.id, admin)).
          to be_an_instance_of PostForm
      end

      it 'returns proper attributes' do
        expect(service.admin_edits_post(post_2.id, admin).to_h).
          to eq post_2_form.to_h
      end
    end

    it 'raises Unauthorized Error if post does not belong to admin' do
      expect { service.admin_edits_post(post_1.id, admin) }.
        to raise_error(Admin::PostService::Unauthorized)
    end
  end

  describe '#admin_publishes_edited_post' do
    let(:post_2_form) do
      PostForm.new(
        id:      post_2.id,
        user_id: admin.id,
        title:   post_attributes[:title],
        body:    post_attributes[:body]
      )
    end
    context 'when post belongs to admin' do
      context 'and attributes are valid' do
        it 'returns Post instance' do
          expect(service.admin_publishes_edited_post(post_2.id, post_attributes, admin)).
            to be_an_instance_of Post
        end

        it 'returns updated Post instance' do
          expect(service.admin_publishes_edited_post(post_2.id, post_attributes, admin).title).
            to eq post_attributes[:title]
        end
      end

      context 'and attributes are invalid' do
        let(:title) { nil }

        it 'returns PostForm instance' do
          expect(service.admin_publishes_edited_post(post_2.id, post_attributes, admin)).
            to be_an_instance_of PostForm
        end

        it 'returns updated Post instance' do
          expect(service.admin_publishes_edited_post(post_2.id, post_attributes, admin).to_h).
            to eq post_2_form.to_h
        end
      end
    end

    it 'raises Unauthorized Error if post does not belong to admin' do
      expect { service.admin_publishes_edited_post(post_1.id, post_attributes, admin) }.
        to raise_error(Admin::PostService::Unauthorized)
    end
  end

  describe '#admin_destroys_post' do
    it 'returns Post when post belongs to admin' do
      expect(service.admin_destroys_post(post_2.id, admin)).
        to eq post_2
    end

    it 'returns post id when post does not belong to admin' do
      expect(service.admin_destroys_post(post_1.id, admin)).to eq post_1.id
    end
  end
end
