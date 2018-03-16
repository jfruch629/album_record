class Review < ApplicationRecord
  belongs_to :album
  belongs_to :user

  validates :body, length:{ minimum: 250 }
end
