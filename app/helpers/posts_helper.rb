module PostsHelper
  def author(user_id)
    User.find(user_id).name
  end
end
