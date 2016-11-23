class PostService
  def initialize(post_repo)
    @post_repo = post_repo
  end

  def load_all_posts
    PostQuery.new.all_from_the_last
  end

  def load_entire_post(post_id)
    @post_repo.find(post_id)
  rescue ActiveRecord::RecordNotFound
    return nil
  end
end
