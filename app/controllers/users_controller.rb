class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @friendship = Friendship.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friendship = Friendship.new
    @pending_invites = Friendship.where(friend_id: current_user.id, confirmed: false)
    @pending_invites += Friendship.where(user_id: current_user.id, confirmed: false)
  end
end
