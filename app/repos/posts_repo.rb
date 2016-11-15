class PostsRepo
  def all_from_the_last
    Post.all.order('created_at DESC')
  end

  def find(post_id)
    Post.find(post_id)
  end

  def new(post_form = nil)
    Post.new(post_form.try(:to_hash))
  end

  def create(post_form)
    Post.create(post_form.to_hash)
  end

  def update(post_id, params)
    find(post_id).tap do |post|
      post.update(params)
    end
  end

  def destroy(post_id)
    find(post_id).destroy
  end
end
