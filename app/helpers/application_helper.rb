module ApplicationHelper
  def url_for_form(post_form)
    post_form.persisted? ? post_path(post_form) : posts_path
  end
end
