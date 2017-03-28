class User < ActiveRecord::Base
  include BCrypt
  validates :library_card,
              length: { is: 10 },
              numericality: { only_integer: true },
              uniqueness: true
  validates :email,
              format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "valid email format" },
              uniqueness: true
  has_many :reservations
  has_many :rentals
  has_secure_password
end
