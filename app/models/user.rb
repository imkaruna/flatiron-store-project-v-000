class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :carts, inverse_of: :user
  has_many :line_items, through: :carts
  has_one :current_cart, class_name: "Cart"


end
