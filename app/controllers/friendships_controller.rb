class FriendshipsController < ApplicationController
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

  def update
    @friendship = Friendship.find(params[:id])

    respond_to do |format|
      if @friendship.update(confirmed: true)
        format.html do
          redirect_to root_path, notice: 'You are now friends!'
        end
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])

    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Friendship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id, :confirmed)
  end
end
