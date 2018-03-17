class AddPhotoToAlbums < ActiveRecord::Migration[5.1]
  def change
    add_column :albums, :photo, :string
  end
end
