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
end
