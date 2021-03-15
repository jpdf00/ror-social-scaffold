module UserHelper
  def added_friend(user, friendship)
    if !current_user.id == user.id && !Friendship.where(user_id: current_user.id,
                                                        friend_id: user.id).or(Friendship.where(
                                                                                 friend_id: current_user.id,
                                                                                 user_id: user.id
                                                                               )).exists?
      render 'invite_button', user: user, friendship: friendship
    end
  end
end
