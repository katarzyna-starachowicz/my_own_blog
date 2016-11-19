module ApplicationHelper
  def url_for_form(post_form)
    post_form.persisted? ? post_path(post_form) : posts_path
  end

  def signed_admins_post?(post)
    admin_signed_in? && current_user == post.user
  end
end
