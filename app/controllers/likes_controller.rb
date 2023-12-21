class LikesController < ApplicationController
  before_action :tweet_params

  def create
    like = current_user.likes.create(tweet_id: params[:tweet_id]) #user_idとtweet_idの二つを代入
    redirect_back(fallback_location: root_path)
  end
    
  def destroy
      like = Like.find_by(tweet_id: params[:tweet_id], user_id: current_user.id)
      like.destroy
      redirect_back(fallback_location: root_path)
  end

  private

  def tweet_params
    @tweet = Tweet.find(params[:id])
  end
      
end
