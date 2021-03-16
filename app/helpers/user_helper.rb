module UserHelper
  def added_friend(user, friendship)
    if current_user.id != user.id && !current_user.friend?(user)
      render 'invite_button', user: user, friendship: friendship
    end
  end

  def rec_invites(user, invite)
    render 'posts/received_invites', received_invites: invite if current_user.id == user.id
  end
end
