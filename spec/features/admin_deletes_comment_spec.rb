require 'rails_helper'

feature 'Admin deletes comments' do
  let(:admin)    { create :user, :admin }
  let!(:post)    { create :post }
  let!(:comment) { create :comment, :on_post, commentable_id: post.id }

  before do
    sign_in_as admin
    click_on 'All posts'
    click_on post.title
  end

  scenario 'deletes a comment' do
    find('.comment_wrapper').click_link 'Delete'

    expect(page).to have_content 'Comment was successfully deleted.'
  end
end
