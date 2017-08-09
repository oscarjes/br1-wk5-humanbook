class FriendshipsController < ApplicationController
  def create
    Friendship.create! friendship_params
    redirect_to users_path
  end

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end

  def destroy
    user = User.find params[:user_id]
    current_user.friends.delete(user)
    redirect_to users_path
  end 
end
