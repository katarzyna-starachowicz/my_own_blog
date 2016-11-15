class PostsRepo
  def all_from_the_last
    Post.all.order('created_at DESC')
  end

  def find(post_id)
    Post.find(post_id)
  end

  def new
    Post.new
  end

  def create(post_params)
    Post.create(post_params)
  end

  def update(post_id, params)
    find.(post_id).tap do |post|
      post.update(params)
    end
  end

  def destroy(post_id)
    find(post_id).destroy
  end
end
