class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :top]

    def top
        @tweets = Tweet.all
    end
    
    def index
        @tweets = Tweet.all
        
        if params[:search] == nil
          @tweets= Tweet.all
        elsif params[:search] == ''
          @tweets= Tweet.all
        else
          #部分検索
          @tweets = Tweet.where("name LIKE ? ",'%' + params[:search] + '%')
        end
        @rank_tweets = Tweet.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}
    end

      def new
        @tweets = Tweet.new
      end
    
      def create
        tweet = Tweet.new(tweet_params)

        tweet.user_id = current_user.id
        
        if tweet.save!
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
      end

      def show
        @tweet = Tweet.find(params[:id])
        @comments = @tweet.comments
        @comment = Comment.new
      end
    
      def edit
        @tweet = Tweet.find(params[:id])
      end

      def update
        tweet = Tweet.find(params[:id])
        if tweet.update(tweet_params)
          redirect_to :action => "show", :id => tweet.id
        else
          redirect_to :action => "new"
        end
      end
      
      def destroy
        tweet = Tweet.find(params[:id])
        tweet.destroy
        redirect_to action: :index
      end

    private
      def tweet_params
        params.require(:tweet).permit(:name, :genre, :year, :about, :comment, :link, :image, :overall)
    end

end
