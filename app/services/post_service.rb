class PostService
  def initialize(posts_repo)
    @posts_repo = posts_repo
  end

  def load_all_posts
    PostsQuery.new.all_from_the_last
  end

  def load_entire_post(post_id)
    @posts_repo.find(post_id)
  end

  def load_empty_post_form
    PostForm.new
  end

  def admin_publishes_post(post_attributes, admin)
    post_form = PostForm.new(
      post_attributes.merge(user_id: admin.id)
    )
    post_form.valid? ? @posts_repo.create(post_form) : post_form
  end
end
