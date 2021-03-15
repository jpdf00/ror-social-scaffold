module UserHelper
  def rec_invites(user, invite)
    render 'posts/received_invites', received_invites: invite if current_user.id == user.id
  end
end
