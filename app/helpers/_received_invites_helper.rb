module ReceivedInvitesHelper
  def received_invites(received_invites)
    out = ''
    received_invites.each do |friendship|
      out += '<div class="confirmations">'
      out += '<span class="profile-link">'
      out += link_to friendship.user.name, user_path(friendship.user), class: 'profile-link'
      out += '</span>'
      out +=  render 'posts/invite_confirm', friendship: friendship
      out +=  render 'posts/invite_reject', friendship: friendship
      out += '</div>'
    end
    out.html_safe
  end
end
