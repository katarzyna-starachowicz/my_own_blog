class PostQuery
  def all_from_the_last
    Post.all.order('created_at DESC')
  end
end
