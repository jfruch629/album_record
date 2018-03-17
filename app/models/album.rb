class Album < ApplicationRecord
  belongs_to :user
  has_many :reviews

  validates_presence_of :title
  validates_presence_of :artist
  validates_presence_of :summary
  validates_presence_of :release_year

  def self.search(search)
  where("title LIKE ? OR artist LIKE ? OR summary LIKE ? OR release_year LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  end

  mount_uploader :photo, PhotoUploader
end
