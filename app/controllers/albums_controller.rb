class AlbumsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = Album.all
    if params[:search]
      @albums = Album.search(params[:search])
    end
    root_path = '/'
    @reviews = Review.all.order('created_at ASC')
  end

  def new
    @album = Album.new
  end

  def show
    @album = Album.find(params[:id])
    @user = User.find(@album.user.id)
    @review = Review.new
    @current_user = current_user
    @album.reviews.order('created_at ASC')
  end

  def create
  @album = Album.new(album_params)
  @album.user = current_user

  respond_to do |format|
    if @album.save
      format.html { redirect_to @album, notice: 'Album was successfully created' }
      format.json { render :show, status: :created, location: @album }
    else
      format.html { render :'/albums/new' }
      format.json { render json: @question.errors, status: :unprocessable_entity }
    end
  end
end

def update
  if @album.update(album_params)
    redirect_to @album, notice: 'Album Updated.'
  else
    render :edit
  end
end

 def destroy
   @album.destroy
   @albums = Album.all
   flash[:notice] = "Album successfully removed."
   render action: "index"
 end


  private
  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:title, :artist, :summary, :genre, :release_year, :tracks, :photo)
  end

  def authorize_user
     if !user_signed_in? || !current_user.admin?
       raise ActionController::RoutingError.new("Not Found")
     end
   end
end
