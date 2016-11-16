module ApplicationHelper
  def url_for_form(post_form)
    post_form.instance_of?(CreatePostForm) ? posts_path : post_path(post_form)
  end
end
