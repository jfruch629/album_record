class User < ApplicationRecord
  has_many :albums
  has_many :reviews

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :email, :presence => true, :email => true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
   self.admin == true
  end

  def self.search(search)
  where("first_name LIKE ? OR last_name LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
