class FriendshipsController < ApplicationController
  def index
    @received_invites = Friendship.where(friend_id: current_user.id, confirmed: false)
    @sent_invites = Friendship.where(user_id: current_user.id, confirmed: false)
  end

  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.user_id = current_user.id

    respond_to do |format|
      # if EventAttendance.where('attendee_id = ? AND attended_event_id = ?', @attendance.attendee_id,
      #                         @attendance.attended_event_id).exists?
      #   format.html do
      #     redirect_to event_path(@attendance.attended_event_id), alert: "You're already attending this event."
      #   end
      #   format.json { render json: @attendance.errors, status: :unprocessable_entity }
      if @friendship.save
        format.html do
          redirect_to users_path, notice: 'Friend request sent!'
        end
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #   # @friendship = Friendship.new
  #   # @friendship.user_id = current_user.id
  #   @friendship = Friendship.where(user_id: params[:user_id], friend_id: current_user, status: false)
  #   @friendship2 = Friendship.where(user_id: current_user, friend_id: params[:user_id], status: false)


  #   respond_to do |format|
  #     if @friendship.update(friendship_params) == true
  #       format.html do
  #         redirect_to users_path, notice: 'You are now friends!'
        
  #       end
  #       format.json { render :show, status: :created, location: @friendship }
  #     else
  #       format.html { render :show, status: :unprocessable_entity }
  #       format.json { render json: @friendship.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id, :confirmed)
  end
end
