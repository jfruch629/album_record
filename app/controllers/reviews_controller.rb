class ReviewsController < ApplicationController
  before_action :set_review, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_album
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @album = Album.find(params[:album_id])
    @reviews = @album.reviews.order('created_at DESC')
    @album.reviews.order('created_at DESC')
    @review = Review.new
  end

  def show
    @review = Review.find(params[:id])
    @album = @review.album
    @review_owner = @review.user
  end

  def edit
  end

  def update
    if @review.update(review_params)
      flash[:notice] = 'Review has been successfully updated'
      redirect_to @album
    else
      flash[:notice] = 'You want to provide a strong review for a good rating, so please provide your explanation with at least 250 characters.'
      render 'edit'
    end
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.album_id = @album.id

    if @review.save
      flash[:notice] = 'Review has been successfully created'
    else
      flash[:notice] = 'You want to provide a strong review for a good rating, so please provide your explanation with at least 250 characters.'
    end
    redirect_to album_path(@album.id)
  end

  def destroy
    @review = Review.find(params[:id])
    @album = @review.album
    @review.destroy
    @reviews = Review.all
    flash[:notice] = "Review successfully removed."
    redirect_to admin_album_path(@album)
  end

  private
    def set_reviews
      @album = Album.find(params[:id])
      @reviews = Review.find(params[:id])
    end

    def set_review
      @review = Review.find(params[:id])
    end

    def set_album
      @album = Album.find(params[:album_id])
    end

    def review_params
      params.require(:review).permit(:body)
    end

    def authorize_user
      if !user_signed_in? || !current_user.admin?
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
