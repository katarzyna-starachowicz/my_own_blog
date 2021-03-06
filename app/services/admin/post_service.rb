module Admin
  class PostService
    Unauthorized = Class.new(StandardError)

    def initialize(post_repo)
      @post_repo = post_repo
    end

    def admin_writes_new_post
      ::PostForm.new
    end

    def admin_publishes_new_post(post_attributes, admin)
      post_form = ::PostForm.new(
        post_attributes.merge(user_id: admin.id)
      )
      post_form.valid? ? @post_repo.create(post_form) : post_form
    end

    def admin_edits_post(post_id, admin)
      post = @post_repo.find_admins_post(admin.id, post_id)
      raise Unauthorized, I18n.t('shared.unauthorized_edit', resource: 'post') if post.nil?

      ::PostForm.new(
        id:      post_id,
        user_id: post.user_id,
        title:   post.title,
        body:    post.body
      )
    end

    def admin_publishes_edited_post(post_id, post_attributes, admin)
      post = @post_repo.find_admins_post(admin.id, post_id)
      raise Unauthorized, I18n.t('shared.unauthorized_edit', resource: 'post') if post.nil?

      post_form = ::PostForm.new(
        post_attributes.merge(
          user_id: admin.id,
          id:      post_id
        )
      )
      post_form.valid? ? @post_repo.update(post_form) : post_form
    end

    def admin_destroys_post(post_id, admin)
      return post_id unless @post_repo.find_admins_post(admin.id, post_id)
      @post_repo.destroy(post_id)
    end
  end
end
