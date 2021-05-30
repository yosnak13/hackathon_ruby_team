class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_q, only: [:index, :search]

  def index
    @posts = Post.all.limit(30)
    @graph = Post.group(:time).average(:congestion_level)
  end

  def about
  end

  def set_q
    @q = Post.ransack(params[:q])
  end

  def search
    @results = @q.result
    @search = Post.where(direction:params[:q][:direction]).where(station_id:params[:q][:station_id])
# binding.pry
    @posts = Post.all
    @graph = @search.group(:time).average(:congestion_level)

  end
  def post_params
    params.require(:post).permit(:comment, :congestion_level, :date, :day_of_week, :time, :direction, :train_type, :station_id)
  end

  
end
