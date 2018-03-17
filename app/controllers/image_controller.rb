class ImagesController < ApplicationController
  def new
    @uploader = Album.new.image
    @uploader.success_action_redirect = new_album_path
  end
end
