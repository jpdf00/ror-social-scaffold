module SentInvitesHelper
  def sent_invites(sent_invites)
    out = ''
    sent_invites.each do |friendship|
      out += '<span class="profile-link">'
      out += link_to friendship.friend.name, user_path(friendship.user), class: 'profile-link'
      out += '</span>'
    end
    out.html_safe
  end
end
