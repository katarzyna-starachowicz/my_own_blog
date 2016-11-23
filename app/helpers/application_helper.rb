module ApplicationHelper
  def signed_admins_post?(post)
    admin_signed_in? && current_user == post.user
  end
end
