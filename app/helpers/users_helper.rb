module UsersHelper
  def render_user
    return content_tag :h1, "You don't have this user" unless @user

    recent_posts_text = @recent_posts.map do |post|
      post.text.truncate(100)
    end
    render partial: '_partials/user_recent_posts',
           locals: { user: @user, posts: @recent_posts, posts_text: recent_posts_text }
  end

  def render_users
    return content_tag :h1, "You don't have any users" unless User.first

    render partial: '_partials/lists/list_users'
  end
end
