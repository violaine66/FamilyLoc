class Propriete < ApplicationRecord
  has_many :reservations, dependent: :destroy
end
