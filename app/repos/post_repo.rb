class PostRepo
  def find(post_id)
    Post.find(post_id)
  end

  def find_admins_post(admin_id, post_id)
    post = find(post_id)
    post.user_id == admin_id ? post : nil
  end

  def create(post_form)
    Post.create(
      title:   post_form.title,
      body:    post_form.body,
      user_id: post_form.user_id
    )
  end

  def update(post_form)
    find(post_form.id).tap do |post|
      post.update(
        title:   post_form.title,
        body:    post_form.body,
        user_id: post_form.user_id
      )
    end
  end

  def destroy(post_id)
    find(post_id).destroy
  end
end
