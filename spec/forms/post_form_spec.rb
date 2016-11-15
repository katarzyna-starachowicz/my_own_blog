require 'rails_helper'

RSpec.describe PostForm do
  subject(:post_form) { described_class.new(attributes) }

  let(:attributes) do
    {
      title: 'My first post',
      body: 'I love writing posts!',
      user_id: 1
    }
  end

  it "is valid with valid attributes" do
    expect(post_form.valid?).to be true
  end

  it "is invalid without title" do
    attributes[:title] = nil
    expect(post_form.valid?).to be false
  end

  it "is invalid without body" do
    attributes[:body] = nil
    expect(post_form.valid?).to be false
  end

  it "is invalid without user_id" do
    attributes[:user_id] = nil
    expect(post_form.valid?).to be false
  end
end
