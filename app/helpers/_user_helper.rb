module UserHelper
  def rec_invites(user, invite)
    if current_user.id == user.id
      render 'posts/received_invites', received_invites: invite
    end 
  end
end
